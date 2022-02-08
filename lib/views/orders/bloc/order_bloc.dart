import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutterlivequery/core/locale/storage.dart';
import 'package:flutterlivequery/core/models/orders_model.dart';
import 'package:flutterlivequery/core/models/products_model.dart';
import 'package:flutterlivequery/core/services/http_service.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitialState()) {
    on(orderEventControl);
  }
  Future<void> orderEventControl(
      OrderEvent event, Emitter<OrderState> emit) async {
    if (event is OrderStartEvent) {
      emit(OrderLoadingState());
      startLiveQuery();
      List<OrdersModel>? orders = await HttpService.i.getOrders();
      List<ProductsModel>? products = await HttpService.i.getProducts();
      if (orders != null && products != null) {
        emit(OrderLoadedState(orders, products));
      } else {
        emit(OrderLoadingErrorState());
      }
    }
  }

  Future<void> startLiveQuery() async {
    LiveQuery liveQuery = LiveQuery();
    final query = QueryBuilder<ParseObject>(ParseObject('Stream'));
    final subscription = await liveQuery.client.subscribe(query);
    subscription.on(LiveQueryEvent.create, (ParseObject value) {
      print("*****CREATE****");
      print(value);
      LocalStorage.streamController.add(value);
    });
  }
}