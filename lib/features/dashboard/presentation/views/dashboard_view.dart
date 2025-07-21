import 'package:flutter/material.dart';
import 'package:fruit_market_dashboard/features/dashboard/presentation/views/widgets/dashboard_view_body.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: DashboardViewBody()));
  }
}
