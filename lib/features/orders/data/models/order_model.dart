import 'package:fruit_market_dashboard/features/orders/data/models/order_product_model.dart';
import 'package:fruit_market_dashboard/features/orders/data/models/shipping_model.dart';

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
        json['orderProducts']
            .map((e) => OrderProductModel.fromJson(e))
            .toList(),
    paymentMethod: json['paymentMethod'],
  );
}
