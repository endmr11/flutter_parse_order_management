import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutterlivequery/core/models/orders_model.dart';
import 'package:flutterlivequery/core/models/products_model.dart';
import 'package:flutterlivequery/core/services/http_service.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitialState()) {
    on(productEventControl);
  }

  Future<void> productEventControl(
      ProductEvent event, Emitter<ProductState> emit) async {
    if (event is ProductStartEvent) {
      emit(ProductLoadingState());
      List<ProductsModel>? products = await HttpService.i.getProducts();
      if (products != null) {
        emit(ProductLoadedState(products));
      } else {
        emit(ProductLoadingErrorState());
      }
    } else if (event is ProductOrderEvent) {
      emit(ProductOrderLoadingState());
      bool postOrder = await HttpService.i.postOrder(event.data);
      if (postOrder) {
        emit(ProductOrderedState(postOrder));
      } else {
        emit(ProductOrderedState(postOrder));
      }
    }
  }
}
