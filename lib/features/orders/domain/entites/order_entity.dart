import 'package:fruit_market_dashboard/features/orders/data/models/order_product_model.dart';
import 'package:fruit_market_dashboard/features/orders/domain/entites/order_product_entity.dart';
import 'package:fruit_market_dashboard/features/orders/domain/entites/shipping_entity.dart';

class OrderEntity {
  final String uID;
  final double totalPrice;
  final ShippingAddressEntity shippingAddressEntity;
  final List<OrderProductEntity> orderProducts;
  final String paymentMethod;

  OrderEntity({
    required this.uID,
    required this.totalPrice,
    required this.shippingAddressEntity,
    required this.orderProducts,
    required this.paymentMethod,
  });

  toJson() => {
    'uID': uID,
    'totalPrice': totalPrice,
    'status': 'pending',
    'date': DateTime.now().toString(),
    'shippingAddressModel': shippingAddressEntity.toJson(),
    'orderProducts': orderProducts.map((e) => e.toJson()).toList(),
    'paymentMethod': paymentMethod,
  };

  factory OrderEntity.fromJson(Map<String, dynamic> json) => OrderEntity(
    uID: json['uID'],
    totalPrice: json['totalPrice'],
    shippingAddressEntity: ShippingAddressEntity.fromJson(
      json['shippingAddressModel'],
    ),
    orderProducts:
        json['orderProducts']
            .map((e) => OrderProductModel.fromJson(e))
            .toList(),
    paymentMethod: json['paymentMethod'],
  );
}
