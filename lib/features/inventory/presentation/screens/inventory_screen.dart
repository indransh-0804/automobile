// lib/features/inventory/presentation/screens/inventory_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_dimensions.dart';
import '../../domain/enums/inventory_tab.dart';
import '../providers/inventory_provider.dart';
import '../widgets/add_inventory_bottom_sheet.dart';
import '../widgets/car_inventory_list.dart';
import '../widgets/inventory_filter_bar.dart';
import '../widgets/inventory_summary_row.dart';
import '../widgets/inventory_tab_bar.dart';
import '../widgets/part_inventory_list.dart';

class InventoryScreen extends ConsumerWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(inventoryProvider);
    final notifier = ref.read(inventoryProvider.notifier);
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: AppDimensions.appBarExpandedHeight,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(
                left: AppDimensions.spacingMd,
                bottom: AppDimensions.spacingMd,
              ),
              title: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Inventory',
                    style: GoogleFonts.syne(
                      fontSize: AppDimensions.fontSizeXl,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Total Value: \$${notifier.totalCarValue.toStringAsFixed(0)}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontSize: AppDimensions.fontSizeXs,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.filter_alt_outlined,
                  size: AppDimensions.iconSizeMd,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  Icons.add_circle_outline,
                  size: AppDimensions.iconSizeMd,
                ),
                onPressed: () => _showAddSheet(context),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppDimensions.spacingSm,
              ),
              child: const InventorySummaryRow(),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.spacingMd,
                vertical: AppDimensions.spacingSm,
              ),
              child: const InventoryTabBar(),
            ),
          ),
          SliverToBoxAdapter(
            child: const InventoryFilterBar(),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: AppDimensions.spacingXl,
              ),
              child: state.activeTab == InventoryTab.cars
                  ? const CarInventoryList()
                  : const PartInventoryList(),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => const AddInventoryBottomSheet(),
    );
  }
}
