import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_market_dashboard/features/orders/domain/entites/order_status.dart';
import 'package:fruit_market_dashboard/features/orders/presentation/manager/Order%20Cubit/orders_cubit.dart';
import 'package:fruit_market_dashboard/features/orders/presentation/views/widgets/order_item.dart';

class OrderItemListview extends StatefulWidget {
  final OrderStatus? statusFilter;
  
  const OrderItemListview({
    super.key,
    this.statusFilter,
  });

  @override
  State<OrderItemListview> createState() => _OrderItemListviewState();
}

class _OrderItemListviewState extends State<OrderItemListview> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<OrdersCubit>().watchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        if (state is OrdersLoaded) {
          // Filter orders based on status
          List<dynamic> filteredOrders = state.orders;
          if (widget.statusFilter != null) {
            filteredOrders = state.orders
                .where((order) => order.status == widget.statusFilter)
                .toList();
          }

          if (filteredOrders.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inbox_outlined,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.statusFilter != null
                        ? 'No ${widget.statusFilter!.displayName} Orders Found'
                        : 'No Orders Found',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Try selecting a different filter or check back later',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: filteredOrders.length,
            itemBuilder: (context, index) => 
                OrderItemWidget(order: filteredOrders[index]),
          );
        } else if (state is OrdersError) {
          return Center(child: Text(state.message));
        } else if (state is OrdersLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Container();
        }
      },
    );
  }
}
