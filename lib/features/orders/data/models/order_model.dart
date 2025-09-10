import 'package:fruit_market_dashboard/features/orders/data/models/order_product_model.dart';
import 'package:fruit_market_dashboard/features/orders/data/models/shipping_model.dart';
import 'package:fruit_market_dashboard/features/orders/domain/entites/order_entity.dart';
import 'package:fruit_market_dashboard/features/orders/domain/entites/order_status.dart';

class OrderModel {
  final String uID;
  final double totalPrice;
  final ShippingAddressModel shippingAddressModel;
  final List<OrderProductModel> orderProducts;
  final String paymentMethod;
  final OrderStatus status;
  final DateTime date;

  OrderModel({
    required this.uID,
    required this.totalPrice,
    required this.shippingAddressModel,
    required this.orderProducts,
    required this.paymentMethod,
    this.status = OrderStatus.pending,
    DateTime? date,
  }) : date = date ?? DateTime.now();

  toJson() => {
    'uID': uID,
    'totalPrice': totalPrice,
    'status': status.value,
    'date': date.toIso8601String(),
    'shippingAddressModel': shippingAddressModel.toJson(),
    'orderProducts': orderProducts.map((e) => e.toJson()).toList(),
    'paymentMethod': paymentMethod,
  };

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    uID: json['uID'],
    totalPrice: json['totalPrice'],
    shippingAddressModel: ShippingAddressModel.fromJson(
      json['shippingAddressModel'],
    ),
    orderProducts:
        (json['orderProducts'] as List)
            .map((e) => OrderProductModel.fromJson(e as Map<String, dynamic>))
            .toList(),
    paymentMethod: json['paymentMethod'],
    status: OrderStatus.fromString(json['status'] ?? 'pending'),
    date: json['date'] != null 
        ? DateTime.parse(json['date']) 
        : DateTime.now(),
  );

  toEntity() => OrderEntity(
    uID: uID,
    totalPrice: totalPrice,
    shippingAddressEntity: shippingAddressModel.toEntity(),
    orderProducts: orderProducts.map((e) => e.toEntity()).toList(),
    paymentMethod: paymentMethod,
    status: status,
    date: date,
  );
}
