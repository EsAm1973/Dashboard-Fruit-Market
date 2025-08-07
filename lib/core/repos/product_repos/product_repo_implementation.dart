import 'package:dartz/dartz.dart';
import 'package:fruit_market_dashboard/core/errors/failures.dart';
import 'package:fruit_market_dashboard/core/repos/product_repos/product_repo.dart';
import 'package:fruit_market_dashboard/core/services/database_service.dart';
import 'package:fruit_market_dashboard/features/add%20product/data/models/add_product_input_model.dart';
import 'package:fruit_market_dashboard/features/add%20product/domain/entities/add_product_input_entity.dart';

class ProductRepoImplementation implements ProductRepo {
  final DatabaseService databaseService;

  ProductRepoImplementation({required this.databaseService});
  @override
  Future<Either<Failures, void>> addProduct(
    AddProductInputEntity addProductInputEntity,
  ) async {
    try {
      print('Uploading product: ${AddProductInputModel.fromEntity(addProductInputEntity).toMap()}');
      await databaseService.addData(
        path: 'products',
        data: AddProductInputModel.fromEntity(addProductInputEntity).toMap(),
      );
      return const Right(null);
    } on Exception catch (e) {
      print('Add product exception: $e');
      return Left(ServerFailure('Failed to add product'));
    }
  }
}
