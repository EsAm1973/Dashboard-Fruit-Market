import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_market_dashboard/features/orders/domain/entites/order_status.dart';
import 'package:fruit_market_dashboard/features/orders/domain/repos/orders_repo.dart';
import 'package:fruit_market_dashboard/features/orders/presentation/manager/Order%20Update%20Status%20Cubit/order_update_states.dart';

class OrderUpdateCubit extends Cubit<OrderUpdateState> {
  final OrdersRepo ordersRepo;
  OrderUpdateCubit(this.ordersRepo) : super(OrderUpdateInitial());

  Future<void> updateOrderStatus({
    required String orderId,
    required OrderStatus status,
  }) async {
    emit(OrderUpdateLoading());
    try {
      await ordersRepo.updateOrderStatus(orderId: orderId, status: status);
      emit(OrderUpdateSuccess());
    } catch (e) {
      emit(OrderUpdateFailure(e.toString()));
    }
  }
}