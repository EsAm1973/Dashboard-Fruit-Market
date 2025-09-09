import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_market_dashboard/features/orders/presentation/manager/Order%20Cubit/orders_cubit.dart';
import 'package:fruit_market_dashboard/features/orders/presentation/views/widgets/order_item.dart';

class OrderItemListview extends StatefulWidget {
  const OrderItemListview({super.key});

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
          if (state.orders.isEmpty) {
            return const Center(child: Text('No Orders Found'));
          }
          return ListView.builder(
            itemCount: state.orders.length,
            itemBuilder:
                (context, index) => OrderItemWidget(order: state.orders[index]),
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
