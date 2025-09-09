import 'package:fruit_market_dashboard/features/orders/data/models/order_product_model.dart';
import 'package:fruit_market_dashboard/features/orders/data/models/shipping_model.dart';
import 'package:fruit_market_dashboard/features/orders/domain/entites/order_entity.dart';

class OrderModel {
  final String uID;
  final double totalPrice;
  final ShippingAddressModel shippingAddressModel;
  final List<OrderProductModel> orderProducts;
  final String paymentMethod;

  OrderModel({
    required this.uID,
    required this.totalPrice,
    required this.shippingAddressModel,
    required this.orderProducts,
    required this.paymentMethod,
  });

  toJson() => {
    'uID': uID,
    'totalPrice': totalPrice,
    'status': 'pending',
    'date': DateTime.now().toString(),
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
  );

  toEntity() => OrderEntity(
    uID: uID,
    totalPrice: totalPrice,
    shippingAddressEntity: shippingAddressModel.toEntity(),
    orderProducts: orderProducts.map((e) => e.toEntity()).toList(),
    paymentMethod: paymentMethod,
  );
}
