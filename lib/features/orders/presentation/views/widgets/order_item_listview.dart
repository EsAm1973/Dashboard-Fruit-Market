import 'package:flutter/material.dart';
import 'package:fruit_market_dashboard/core/helper_functions/get_order_dummy_data.dart';
import 'package:fruit_market_dashboard/features/orders/presentation/views/widgets/order_item.dart';

class OrderItemListview extends StatelessWidget {
  const OrderItemListview({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) => OrderItemWidget(order: getDummyOrder()),
    );
  }
}
