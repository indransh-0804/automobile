import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'route_names.dart';
import '../../features/dashboard/screens/dashboard_screen.dart';

// Stub auth provider — replace with real auth state check when authentication is implemented.
final authStateProvider = Provider<bool>((ref) => true);

final goRouterProvider = Provider<GoRouter>((ref) {
  final isAuthenticated = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: RouteNames.splash,
    redirect: (BuildContext context, GoRouterState state) {
      // TODO: Replace this stub with a real auth guard once authentication is wired up.
      // Currently always authenticated; redirect unauthenticated users to login.
      final attemptingProtectedRoute = state.matchedLocation != RouteNames.login &&
          state.matchedLocation != RouteNames.splash;
      if (!isAuthenticated && attemptingProtectedRoute) {
        return RouteNames.login;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: RouteNames.splash,
        name: 'splash',
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: RouteNames.login,
        name: 'login',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Login Screen')),
        ),
      ),
      GoRoute(
        path: RouteNames.dashboard,
        name: 'dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: RouteNames.inventory,
        name: 'inventory',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Inventory Screen')),
        ),
      ),
      GoRoute(
        path: RouteNames.catalogue,
        name: 'catalogue',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Catalogue Screen')),
        ),
      ),
      GoRoute(
        path: RouteNames.purchase,
        name: 'purchase',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Purchase Screen')),
        ),
      ),
      GoRoute(
        path: RouteNames.loan,
        name: 'loan',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Loan Screen')),
        ),
      ),
      GoRoute(
        path: RouteNames.billing,
        name: 'billing',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Billing Screen')),
        ),
      ),
      GoRoute(
        path: RouteNames.testDrive,
        name: 'testDrive',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Test Drive Screen')),
        ),
      ),
      GoRoute(
        path: RouteNames.serviceAppointment,
        name: 'serviceAppointment',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Service Appointment Screen')),
        ),
      ),
      GoRoute(
        path: RouteNames.reports,
        name: 'reports',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Reports Screen')),
        ),
      ),
      GoRoute(
        path: RouteNames.alerts,
        name: 'alerts',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Alerts Screen')),
        ),
      ),
    ],
  );
});
