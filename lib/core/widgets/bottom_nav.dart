import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:automobile/providers/dashboard_provider.dart';

class DashboardBottomNav extends ConsumerWidget {
  final List<BottomNavigationBarItem> items;

  const DashboardBottomNav({super.key, required this.items});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final index = ref.watch(bottomNavIndexProvider);

    return BottomNavigationBar(
      currentIndex: index,
      onTap: (i) => ref.read(bottomNavIndexProvider.notifier).state = i,
      backgroundColor: cs.surface,
      selectedItemColor: cs.primary,
      unselectedItemColor: cs.outline,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      items: items,
    );
  }
}