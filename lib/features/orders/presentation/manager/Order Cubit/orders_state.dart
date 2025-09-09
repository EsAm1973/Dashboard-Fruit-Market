part of 'orders_cubit.dart';

@immutable
abstract class OrdersState {}

class OrdersInitial extends OrdersState {}

class OrdersLoading extends OrdersState {}

class OrdersLoaded extends OrdersState {
  final List<OrderEntity> orders;
  
  OrdersLoaded(this.orders);
}

class OrdersError extends OrdersState {
  final String message;
  
  OrdersError(this.message);
}