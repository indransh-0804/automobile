import 'package:go_router/go_router.dart';
import 'package:automobile/core/router/route_names.dart';
import 'package:automobile/features/dashboard/screens/owner_dashboard_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: RouteNames.dashboard,
      builder: (context, state) => const OwnerDashboardScreen(),
    ),
  ],
);
