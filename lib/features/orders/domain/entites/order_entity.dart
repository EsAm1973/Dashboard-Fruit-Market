import 'package:fruit_market_dashboard/features/orders/domain/entites/order_product_entity.dart';
import 'package:fruit_market_dashboard/features/orders/domain/entites/order_status.dart';
import 'package:fruit_market_dashboard/features/orders/domain/entites/shipping_entity.dart';

class OrderEntity {
  final String id;
  final String uID;
  final double totalPrice;
  final ShippingAddressEntity shippingAddressEntity;
  final List<OrderProductEntity> orderProducts;
  final String paymentMethod;
  final OrderStatus status;
  final DateTime date;

  OrderEntity({
    required this.id,
    required this.uID,
    required this.totalPrice,
    required this.shippingAddressEntity,
    required this.orderProducts,
    required this.paymentMethod,
    this.status = OrderStatus.pending,
    DateTime? date,
  }) : date = date ?? DateTime.now();

  toJson() => {
    'id': id,
    'uID': uID,
    'totalPrice': totalPrice,
    'status': status.value,
    'date': date.toIso8601String(),
    'shippingAddressModel': shippingAddressEntity.toJson(),
    'orderProducts': orderProducts.map((e) => e.toJson()).toList(),
    'paymentMethod': paymentMethod,
  };

  factory OrderEntity.fromJson(Map<String, dynamic> json) => OrderEntity(
    id: json['id'],
    uID: json['uID'],
    totalPrice: json['totalPrice'],
    shippingAddressEntity: ShippingAddressEntity.fromJson(
      json['shippingAddressModel'],
    ),
    orderProducts:
        (json['orderProducts'] as List)
            .map((e) => OrderProductEntity.fromJson(e as Map<String, dynamic>))
            .toList(),
    paymentMethod: json['paymentMethod'],
    status: OrderStatus.fromString(json['status'] ?? 'pending'),
    date: json['date'] != null 
        ? DateTime.parse(json['date']) 
        : DateTime.now(),
  );
}
