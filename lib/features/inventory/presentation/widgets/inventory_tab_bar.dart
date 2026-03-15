// lib/features/inventory/presentation/widgets/inventory_tab_bar.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_dimensions.dart';
import '../../domain/enums/inventory_tab.dart';
import '../providers/inventory_provider.dart';

class InventoryTabBar extends ConsumerWidget {
  const InventoryTabBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeTab = ref.watch(inventoryProvider).activeTab;
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppDimensions.spacingXs),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
      ),
      child: Row(
        children: InventoryTab.values.map((tab) {
          final isActive = tab == activeTab;

          return Expanded(
            child: GestureDetector(
              onTap: () => ref.read(inventoryProvider.notifier).setTab(tab),
              child: Container(
                height: AppDimensions.tabBarHeight,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isActive
                      ? theme.colorScheme.primary
                      : Colors.transparent,
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusFull),
                ),
                child: Text(
                  tab.label,
                  style: GoogleFonts.syne(
                    fontSize: AppDimensions.fontSizeMd,
                    fontWeight: FontWeight.w600,
                    color: isActive
                        ? theme.colorScheme.onPrimary
                        : theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
