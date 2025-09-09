import 'package:fruit_market_dashboard/core/services/database_service.dart';
import 'package:fruit_market_dashboard/features/orders/data/models/order_model.dart';
import 'package:fruit_market_dashboard/features/orders/domain/entites/order_entity.dart';
import 'package:fruit_market_dashboard/features/orders/domain/repos/orders_repo.dart';

class OrdersRepoImpl implements OrdersRepo {
  final DatabaseService databaseService;
  OrdersRepoImpl({required this.databaseService});
  @override
  // Future<Either<Failures, List<OrderEntity>>> getOrders() async {
  //   try {
  //     final ordersData = await databaseService.getAllData(path: 'orders');

  //     final orders = ordersData
  //         .map<OrderEntity>(
  //           (data) => OrderModel.fromJson(data).toEntity(),
  //         ) // تحويل Model إلى Entity
  //         .toList();

  //     return Right(orders);
  //   } on FirebaseException catch (e) {
  //     return Left(ServerFailure(e.message!));
  //   } catch (e) {
  //     return Left(ServerFailure(e.toString()));
  //   }
  // }

  @override
  Stream<List<OrderEntity>> watchOrders() {
    return databaseService
        .watchAllData(path: 'orders')
        .map<List<OrderEntity>>((dataList) {
          return dataList
              .map<OrderEntity>((data) => OrderModel.fromJson(data).toEntity())
              .toList();
        })
        .handleError((error) {
          // يمكنك هنا تحويل الأخطاء إلى استثناءات مناسبة
          throw error;
        });
  }
}
