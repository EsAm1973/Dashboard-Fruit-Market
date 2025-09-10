import 'package:fruit_market_dashboard/features/orders/domain/entites/order_entity.dart';
import 'package:fruit_market_dashboard/features/orders/domain/entites/order_status.dart';

abstract class OrdersRepo {
  //Future<Either<Failures, List<OrderEntity>>> getOrders();
  Stream<List<OrderEntity>> watchOrders();
  Future<void> updateOrderStatus({
    required String orderId,
    required OrderStatus status,
  });
}