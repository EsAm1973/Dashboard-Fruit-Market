import 'package:fruit_market_dashboard/features/dashboard/presentation/views/dashboard_view.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static const String kDashboardViewRoute = '/';
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: kDashboardViewRoute,
        builder: (context, state) => const DashboardView(),
      ),
    ],
  );
}
