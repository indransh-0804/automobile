import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:automobile/ui/screens/dashboard_screen.dart';
import 'package:automobile/ui/screens/employee_dashboard_screen.dart';

final GoRouter goRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      redirect: (context, state) {
        final role = Hive.box('roleBox').get('role', defaultValue: 'owner');
        return role == 'employee' ? '/employee_dashboard' : '/owner_dashboard';
      },
    ),
    GoRoute(
      path: '/owner_dashboard',
      builder: (context, state) => const OwnerDashboardScreen(),
    ),
    GoRoute(
      path: '/employee_dashboard',
      builder: (context, state) => const EmployeeDashboardScreen(),
    ),
  ],
);