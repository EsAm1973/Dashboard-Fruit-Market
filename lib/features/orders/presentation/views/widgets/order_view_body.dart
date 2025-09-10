import 'package:flutter/material.dart';
import 'package:fruit_market_dashboard/features/orders/domain/entites/order_status.dart';
import 'package:fruit_market_dashboard/features/orders/presentation/views/widgets/filter_section.dart';
import 'package:fruit_market_dashboard/features/orders/presentation/views/widgets/order_item_listview.dart';

class OrderViewBody extends StatefulWidget {
  const OrderViewBody({super.key});

  @override
  State<OrderViewBody> createState() => _OrderViewBodyState();
}

class _OrderViewBodyState extends State<OrderViewBody> {
  OrderStatus? selectedStatus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          FilterSection(
            selectedStatus: selectedStatus,
            onStatusChanged: (status) {
              setState(() {
                selectedStatus = status;
              });
            },
          ),
          Expanded(
            child: OrderItemListview(
              statusFilter: selectedStatus,
            ),
          ),
        ],
      ),
    );
  }
}
