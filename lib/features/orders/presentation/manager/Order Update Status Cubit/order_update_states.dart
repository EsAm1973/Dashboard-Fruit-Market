abstract class OrderUpdateState {}

class OrderUpdateInitial extends OrderUpdateState {}

class OrderUpdateLoading extends OrderUpdateState {}

class OrderUpdateSuccess extends OrderUpdateState {}

class OrderUpdateFailure extends OrderUpdateState {
  final String message;
  OrderUpdateFailure(this.message);
}
