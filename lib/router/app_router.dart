// lib/router/app_router.dart
import 'package:go_router/go_router.dart';

import '../features/inventory/presentation/screens/inventory_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/inventory',
    routes: [
      GoRoute(
        path: '/inventory',
        builder: (context, state) => const InventoryScreen(),
      ),
    ],
  );
}
