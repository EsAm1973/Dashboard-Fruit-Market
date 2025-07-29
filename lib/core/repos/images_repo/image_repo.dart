import 'package:dartz/dartz.dart';
import 'package:fruit_market_dashboard/core/errors/failures.dart';

abstract class ImageRepo {
  Future<Either<Failures, String>> uploadImage(String path);
}
