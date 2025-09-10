import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fruit_market_dashboard/features/orders/domain/entites/order_entity.dart';
import 'package:fruit_market_dashboard/features/orders/domain/repos/orders_repo.dart';
import 'package:meta/meta.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final OrdersRepo ordersRepo;
  StreamSubscription? ordersStreamSubscription;
  OrdersCubit(this.ordersRepo) : super(OrdersInitial());

  // Future<void> getOrders() async {
  //   emit(OrdersLoading());

  //   final either = await ordersRepo.getOrders();

  //   either.fold(
  //     (failure) => emit(OrdersError(failure.message)),
  //     (orders) => emit(OrdersLoaded(orders)),
  //   );
  // }

  void watchOrders() {
    ordersStreamSubscription?.cancel();
    emit(OrdersLoading());

    ordersStreamSubscription = ordersRepo.watchOrders().listen(
      (orders) {
        // الآن كل order سيكون له id (document ID)
        emit(OrdersLoaded(orders));
      },
      onError: (error) {
        emit(OrdersError(error.toString()));
      },
    );
  }

  @override
  Future<void> close() {
    ordersStreamSubscription?.cancel();
    return super.close();
  }
}
