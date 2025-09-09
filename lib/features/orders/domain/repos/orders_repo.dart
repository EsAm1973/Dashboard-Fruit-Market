import 'package:dartz/dartz.dart';
import 'package:fruit_market_dashboard/core/errors/failures.dart';
import 'package:fruit_market_dashboard/features/orders/domain/entites/order_entity.dart';

abstract class OrdersRepo {
  Future<Either<Failures, List<OrderEntity>>> getOrders();
}