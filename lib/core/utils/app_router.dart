import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_market_dashboard/core/repos/images_repo/image_repo.dart';
import 'package:fruit_market_dashboard/core/repos/product_repos/product_repo.dart';
import 'package:fruit_market_dashboard/core/services/getit_service.dart';
import 'package:fruit_market_dashboard/features/add%20product/presentation/manager/add%20product/add_product_cubit.dart';
import 'package:fruit_market_dashboard/features/add%20product/presentation/views/add_product_view.dart';
import 'package:fruit_market_dashboard/features/dashboard/presentation/views/dashboard_view.dart';
import 'package:fruit_market_dashboard/features/orders/domain/repos/orders_repo.dart';
import 'package:fruit_market_dashboard/features/orders/presentation/manager/Order%20Cubit/orders_cubit.dart';
import 'package:fruit_market_dashboard/features/orders/presentation/views/order_view.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static const String kDashboardViewRoute = '/';
  static const String kAddProductViewRoute = '/add-product';
  static const String kOrdersViewRoute = '/orders';
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: kDashboardViewRoute,
        builder: (context, state) => const DashboardView(),
      ),
      GoRoute(
        path: kAddProductViewRoute,
        builder:
            (context, state) => BlocProvider(
              create:
                  (context) => AddProductCubit(
                    getIt.get<ImageRepo>(),
                    getIt.get<ProductRepo>(),
                  ),
              child: const AddProductView(),
            ),
      ),
      GoRoute(
        path: kOrdersViewRoute,
        builder:
            (context, state) => BlocProvider(
              create: (context) => OrdersCubit(getIt.get<OrdersRepo>()),
              child: const OrderView(),
            ),
      ),
    ],
  );
}
