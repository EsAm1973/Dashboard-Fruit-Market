import 'package:flutter/material.dart';
import 'package:fruit_market_dashboard/core/widgets/custom_buttom.dart';

class DashboardViewBody extends StatelessWidget {
  const DashboardViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [CustomButtom(onpressed: () {}, text: 'Add Data')],
      ),
    );
  }
}
