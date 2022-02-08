part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitialState extends OrderState {}

class OrderLoadingState extends OrderState {}

class OrderLoadedState extends OrderState {
  final List<OrdersModel> orders;
  final List<ProductsModel> products;
  const OrderLoadedState(this.orders,this.products);
  @override
  List<Object> get props => [orders];
}



class OrderLoadingErrorState extends OrderState {}
