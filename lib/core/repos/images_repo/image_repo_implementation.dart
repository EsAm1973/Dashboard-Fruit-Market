import 'package:dartz/dartz.dart';
import 'package:fruit_market_dashboard/core/errors/failures.dart';
import 'package:fruit_market_dashboard/core/repos/images_repo/image_repo.dart';

class ImageRepoImplementation implements ImageRepo {
  @override
  Future<Either<Failures, String>> uploadImage(String path) {
    // TODO: implement uploadImage
    throw UnimplementedError();
  }
}
