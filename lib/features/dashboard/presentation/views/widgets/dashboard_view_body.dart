import 'package:flutter/material.dart';
import 'package:fruit_market_dashboard/core/utils/app_router.dart';
import 'package:fruit_market_dashboard/core/widgets/custom_buttom.dart';
import 'package:go_router/go_router.dart';

class DashboardViewBody extends StatelessWidget {
  const DashboardViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButtom(
            onpressed: () {
              GoRouter.of(context).push(AppRouter.kAddProductViewRoute);
            },
            text: 'Add Data',
          ),
          const SizedBox(height: 20),
          CustomButtom(onpressed: () {
            GoRouter.of(context).push(AppRouter.kOrdersViewRoute);
          }, text: 'View Orders'),
        ],
      ),
    );
  }
}
