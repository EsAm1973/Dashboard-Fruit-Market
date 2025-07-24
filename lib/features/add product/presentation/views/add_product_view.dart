import 'package:flutter/material.dart';
import 'package:fruit_market_dashboard/core/utils/app_text_styles.dart';
import 'package:fruit_market_dashboard/features/add%20product/presentation/views/widgets/add_product_view_body.dart';

class AddProductView extends StatelessWidget {
  const AddProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.green.shade900,
        centerTitle: true,
        title: const Text('Add Product', style: AppTextStyles.bold23),
      ),
      body: SafeArea(child: AddProductViewBody()),
    );
  }
}
