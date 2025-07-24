import 'package:fruit_market_dashboard/features/add%20product/presentation/views/add_product_view.dart';
import 'package:fruit_market_dashboard/features/dashboard/presentation/views/dashboard_view.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static const String kDashboardViewRoute = '/';
  static const String kAddProductViewRoute = '/add-product';
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: kDashboardViewRoute,
        builder: (context, state) => const DashboardView(),
      ),
      GoRoute(
        path: kAddProductViewRoute,
        builder: (context, state) => const AddProductView(),
      ),
    ],
  );
}
