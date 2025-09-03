// مثال دالة تُعيد OrderModel مكتمل
import 'package:fruit_market_dashboard/features/orders/data/models/order_model.dart';
import 'package:fruit_market_dashboard/features/orders/data/models/order_product_model.dart';
import 'package:fruit_market_dashboard/features/orders/data/models/shipping_model.dart';

OrderModel getDummyOrder({
  String uID = 'ORD-20250903-001',
  String paymentMethod = 'Credit Card',
}) {
  // عين بعض المنتجات كمثال
  final products = <OrderProductModel>[
    OrderProductModel(
      name: 'Wireless Headphones',
      code: 'WH-001',
      price: 79.99,
      imageUrl: 'https://example.com/images/headphones.jpg',
      quantity: 1,
    ),
    OrderProductModel(
      name: 'USB-C Charger',
      code: 'UC-123',
      price: 19.50,
      imageUrl: 'https://example.com/images/charger.jpg',
      quantity: 2,
    ),
    OrderProductModel(
      name: 'Phone Case',
      code: 'PC-09',
      price: 9.0,
      imageUrl: null,
      quantity: 1,
    ),
  ];

  // حساب الـ total من مجموع كل المنتجات (price * quantity)
  final total = products.fold<double>(
    0.0,
    (sum, p) => sum + p.price.toDouble() * p.quantity,
  );

  // عنوان الشحن كمثال
  final shipping = ShippingAddressModel(
    name: 'Ahmed Ali',
    address: '123 Nile Street',
    city: 'Cairo',
    email: 'ahmed.ali@example.com',
    phone: '+201234567890',
    addressDescription: 'Apartment 5, Building A',
  );

  // إرجاع الـ OrderModel كامل
  return OrderModel(
    uID: uID,
    totalPrice: total,
    shippingAddressModel: shipping,
    orderProducts: products,
    paymentMethod: paymentMethod,
  );
}
