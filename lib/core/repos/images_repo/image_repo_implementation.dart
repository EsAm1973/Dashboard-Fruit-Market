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
      print('Starting image upload...');
      String imageUrl = await storageService.uploadFile(image, 'images');
      print('Upload successful! URL: $imageUrl');
      return Right(imageUrl);
    } on Exception catch (e) {
      print('Upload failed with error: $e');
      return Left(ServerFailure(e.toString()));
    }
  }
}
