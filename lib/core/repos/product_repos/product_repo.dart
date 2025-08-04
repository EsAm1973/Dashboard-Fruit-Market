import 'package:dartz/dartz.dart';
import 'package:fruit_market_dashboard/core/errors/failures.dart';
import 'package:fruit_market_dashboard/features/add%20product/domain/entities/add_product_input_entity.dart';

abstract class ProductRepo {
  Future<Either<Failures, void>> addProduct(
    AddProductInputEntity addProductInputEntity,
  );
}
