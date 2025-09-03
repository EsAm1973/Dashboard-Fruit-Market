class OrderProductModel {
  final String name;
  final String code;
  final num price;
  final String? imageUrl;
  final int quantity;

  OrderProductModel({
    required this.name,
    required this.code,
    required this.price,
    required this.imageUrl,
    required this.quantity,
  });

  toJson() => {
    "name": name,
    "code": code,
    "price": price,
    "quantity": quantity,
    "imageUrl": imageUrl,
  };

  factory OrderProductModel.fromJson(Map<String, dynamic> json) => OrderProductModel(
    name: json["name"],
    code: json["code"],
    price: json["price"],
    imageUrl: json["imageUrl"],
    quantity: json["quantity"],
  );
}
