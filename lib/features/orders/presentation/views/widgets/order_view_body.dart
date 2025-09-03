import 'package:flutter/material.dart';
import 'package:fruit_market_dashboard/features/orders/presentation/views/widgets/filter_section.dart';
import 'package:fruit_market_dashboard/features/orders/presentation/views/widgets/order_item_listview.dart';

class OrderViewBody extends StatelessWidget {
  const OrderViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          FilterSection(),
          Expanded(child: OrderItemListview()),
        ],
      ),
    );
  }
}
