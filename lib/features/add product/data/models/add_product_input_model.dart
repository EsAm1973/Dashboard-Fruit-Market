import 'dart:io';

import 'package:fruit_market_dashboard/features/add%20product/data/models/review_model.dart';
import 'package:fruit_market_dashboard/features/add%20product/domain/entities/add_product_input_entity.dart';

class AddProductInputModel {
  final String productName;
  final String productCode;
  final num price;
  final String description;
  String? imageUrl;
  final File fileImage;
  final bool isFeatured;
  final int expiryDate;
  final bool isOrganic;
  final int unitAmount;
  final int numberOfCalories;
  final num averageRating;
  final num ratingCount;
  final int sillingCount;
  final List<ReviewModel> reviews;

  AddProductInputModel({
    required this.productName,
    required this.productCode,
    required this.price,
    required this.description,
    this.imageUrl,
    required this.fileImage,
    required this.isFeatured,
    required this.expiryDate,
    required this.isOrganic,
    required this.unitAmount,
    required this.numberOfCalories,
    required this.averageRating,
    required this.ratingCount,
    required this.reviews,
    this.sillingCount = 0,
  });

  factory AddProductInputModel.fromEntity(
    AddProductInputEntity addProductInputEntity,
  ) => AddProductInputModel(
    productName: addProductInputEntity.productName,
    productCode: addProductInputEntity.productCode,
    price: addProductInputEntity.price,
    description: addProductInputEntity.description,
    imageUrl: addProductInputEntity.imageUrl,
    fileImage: addProductInputEntity.fileImage,
    isFeatured: addProductInputEntity.isFeatured,
    expiryDate: addProductInputEntity.expiryDate,
    isOrganic: addProductInputEntity.isOrganic,
    unitAmount: addProductInputEntity.unitAmount,
    numberOfCalories: addProductInputEntity.numberOfCalories,
    averageRating: addProductInputEntity.averageRating,
    ratingCount: addProductInputEntity.ratingCount,
    reviews:
        addProductInputEntity.reviews
            .map((e) => ReviewModel.fromEntity(e))
            .toList(),
  );

  toMap() {
    return {
      'productName': productName,
      'productCode': productCode,
      'price': price,
      'description': description,
      'imageUrl': imageUrl,
      'isFeatured': isFeatured,
      'expiryDate': expiryDate,
      'isOrganic': isOrganic,
      'unitAmount': unitAmount,
      'numberOfCalories': numberOfCalories,
      'averageRating': averageRating,
      'ratingCount': ratingCount,
      'reviews': reviews.map((review) => review.toJson()).toList(),
      'sillingCount': sillingCount,
    };
  }
}
