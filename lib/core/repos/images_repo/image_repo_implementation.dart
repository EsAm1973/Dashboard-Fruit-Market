import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:fruit_market_dashboard/core/errors/failures.dart';
import 'package:fruit_market_dashboard/core/repos/images_repo/image_repo.dart';
import 'package:fruit_market_dashboard/core/services/storage_service.dart';

class ImageRepoImplementation implements ImageRepo {
  final StorageService storageService;

  ImageRepoImplementation({required this.storageService});
  @override
  Future<Either<Failures, String>> uploadImage(File image) async {
    try {
      String imageUrl = await storageService.uploadFile(image, 'images');
      return Right(imageUrl);
    } on Exception {
      return Left(ServerFailure('Failed to upload image'));
    }
  }
}
