part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class ProductStartEvent extends ProductEvent {}

class ProductOrderEvent extends ProductEvent {
  final Map<String,dynamic> data;
  const ProductOrderEvent(this.data);

  @override
  List<Object> get props => [data];
}
