import 'package:flutter/material.dart';
import 'package:fruit_market_dashboard/core/utils/app_colors.dart';
import 'package:fruit_market_dashboard/core/utils/app_text_styles.dart';
import 'package:fruit_market_dashboard/features/orders/presentation/views/widgets/order_view_body.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        title: const Text('Orders'),
        centerTitle: true,
        titleTextStyle: AppTextStyles.bold28,
      ),
      body: const SafeArea(child: OrderViewBody()),
    );
  }
}
