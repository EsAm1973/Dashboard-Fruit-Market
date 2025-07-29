import 'dart:io';

class AddProductInputEntity {
  final String productName;
  final String productCode;
  final num price;
  final String description;
  final String? imageUrl;
  final File fileImage;
  final bool isFeatured;

  AddProductInputEntity({
    required this.productName,
    required this.productCode,
    required this.price,
    required this.description,
    this.imageUrl,
    required this.fileImage,
    required this.isFeatured,
  });
}
