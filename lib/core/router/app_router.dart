import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:automobile/core/router/route_names.dart';
import 'package:automobile/providers/auth_provider.dart';
import 'package:automobile/features/auth/screens/login_screen.dart';
import 'package:automobile/features/dashboard/screens/owner_dashboard_screen.dart';
import 'package:automobile/features/inventory/screens/inventory_screen.dart';
import 'package:automobile/features/inventory/screens/add_car_screen.dart';
import 'package:automobile/features/inventory/screens/add_spare_part_screen.dart';
import 'package:automobile/features/catalog/screens/car_catalog_screen.dart';
import 'package:automobile/features/purchase/screens/purchase_form_screen.dart';
import 'package:automobile/features/loans/screens/loan_screen.dart';
import 'package:automobile/features/loans/screens/loan_form_screen.dart';
import 'package:automobile/features/sales/screens/sales_summary_screen.dart';
import 'package:automobile/features/test_drive/screens/test_drive_screen.dart';
import 'package:automobile/features/test_drive/screens/test_drive_form_screen.dart';
import 'package:automobile/features/appointments/screens/appointments_screen.dart';
import 'package:automobile/features/appointments/screens/appointment_form_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/dashboard',
    redirect: (context, state) {
      final isLoggedIn = authState.whenOrNull(data: (user) => user != null) ?? false;
      final isLoginRoute = state.matchedLocation == '/login';

      if (!isLoggedIn && !isLoginRoute) {
        return '/login';
      }
      if (isLoggedIn && isLoginRoute) {
        return '/dashboard';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        name: RouteNames.login,
        builder: (context, state) => const LoginScreen(),
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return MainShellScaffold(child: child);
        },
        routes: [
          GoRoute(
            path: '/dashboard',
            name: RouteNames.dashboard,
            builder: (context, state) => const OwnerDashboardScreen(),
          ),
          GoRoute(
            path: '/inventory',
            name: RouteNames.inventory,
            builder: (context, state) => const InventoryScreen(),
          ),
          GoRoute(
            path: '/add-car',
            name: RouteNames.addCar,
            builder: (context, state) => const AddCarScreen(),
          ),
          GoRoute(
            path: '/add-spare-part',
            name: RouteNames.addSparePart,
            builder: (context, state) => const AddSparePartScreen(),
          ),
          GoRoute(
            path: '/car-catalog',
            name: RouteNames.carCatalog,
            builder: (context, state) => const CarCatalogScreen(),
          ),
          GoRoute(
            path: '/purchase-form',
            name: RouteNames.purchaseForm,
            builder: (context, state) => const PurchaseFormScreen(),
          ),
          GoRoute(
            path: '/loans',
            name: RouteNames.loans,
            builder: (context, state) => const LoanScreen(),
          ),
          GoRoute(
            path: '/loan-form',
            name: RouteNames.loanForm,
            builder: (context, state) => const LoanFormScreen(),
          ),
          GoRoute(
            path: '/sales-summary',
            name: RouteNames.salesSummary,
            builder: (context, state) => const SalesSummaryScreen(),
          ),
          GoRoute(
            path: '/test-drives',
            name: RouteNames.testDrives,
            builder: (context, state) => const TestDriveScreen(),
          ),
          GoRoute(
            path: '/test-drive-form',
            name: RouteNames.testDriveForm,
            builder: (context, state) => const TestDriveFormScreen(),
          ),
          GoRoute(
            path: '/appointments',
            name: RouteNames.appointments,
            builder: (context, state) => const AppointmentsScreen(),
          ),
          GoRoute(
            path: '/appointment-form',
            name: RouteNames.appointmentForm,
            builder: (context, state) => const AppointmentFormScreen(),
          ),
        ],
      ),
    ],
  );
});

class MainShellScaffold extends ConsumerWidget {
  final Widget child;

  const MainShellScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final currentLocation = GoRouterState.of(context).matchedLocation;

    return Scaffold(
      drawer: NavigationDrawer(
        selectedIndex: _selectedIndex(currentLocation),
        onDestinationSelected: (index) {
          Navigator.of(context).pop();
          _onDestinationSelected(context, index);
        },
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              context.drawerPadding,
              context.drawerPadding * 2,
              context.drawerPadding,
              context.drawerPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  authState.whenOrNull(
                        data: (user) => user?.displayName ?? 'Owner',
                      ) ??
                      'Owner',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  authState.whenOrNull(
                        data: (user) => user?.email ?? '',
                      ) ??
                      '',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          const Divider(),
          const NavigationDrawerDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: Text('Dashboard'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.inventory_2_outlined),
            selectedIcon: Icon(Icons.inventory_2),
            label: Text('Inventory'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.directions_car_outlined),
            selectedIcon: Icon(Icons.directions_car),
            label: Text('Car Catalog'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.shopping_cart_outlined),
            selectedIcon: Icon(Icons.shopping_cart),
            label: Text('Purchases'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.account_balance_outlined),
            selectedIcon: Icon(Icons.account_balance),
            label: Text('Loans'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.trending_up_outlined),
            selectedIcon: Icon(Icons.trending_up),
            label: Text('Sales Summary'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.car_rental_outlined),
            selectedIcon: Icon(Icons.car_rental),
            label: Text('Test Drives'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.calendar_today_outlined),
            selectedIcon: Icon(Icons.calendar_today),
            label: Text('Service Appointments'),
          ),
        ],
      ),
      body: child,
    );
  }

  int _selectedIndex(String location) {
    if (location.startsWith('/dashboard')) return 0;
    if (location.startsWith('/inventory') ||
        location.startsWith('/add-car') ||
        location.startsWith('/add-spare-part')) return 1;
    if (location.startsWith('/car-catalog')) return 2;
    if (location.startsWith('/purchase-form')) return 3;
    if (location.startsWith('/loans') || location.startsWith('/loan-form')) {
      return 4;
    }
    if (location.startsWith('/sales-summary')) return 5;
    if (location.startsWith('/test-drive')) return 6;
    if (location.startsWith('/appointment')) return 7;
    return 0;
  }

  void _onDestinationSelected(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.goNamed(RouteNames.dashboard);
        break;
      case 1:
        context.goNamed(RouteNames.inventory);
        break;
      case 2:
        context.goNamed(RouteNames.carCatalog);
        break;
      case 3:
        context.goNamed(RouteNames.purchaseForm);
        break;
      case 4:
        context.goNamed(RouteNames.loans);
        break;
      case 5:
        context.goNamed(RouteNames.salesSummary);
        break;
      case 6:
        context.goNamed(RouteNames.testDrives);
        break;
      case 7:
        context.goNamed(RouteNames.appointments);
        break;
    }
  }
}

extension _DrawerPaddingExtension on BuildContext {
  double get drawerPadding => MediaQuery.of(this).size.width * 0.04;
}
