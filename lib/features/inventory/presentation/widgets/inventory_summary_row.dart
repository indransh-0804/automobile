// lib/features/inventory/presentation/widgets/inventory_summary_row.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_dimensions.dart';
import '../../../../shared/widgets/app_data_chip.dart';
import '../providers/inventory_provider.dart';

class InventorySummaryRow extends ConsumerWidget {
  const InventorySummaryRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(inventoryProvider);
    final notifier = ref.read(inventoryProvider.notifier);
    final theme = Theme.of(context);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacingMd,
      ),
      child: Row(
        children: [
          AppDataChip(
            label: 'Total Cars',
            value: '${state.cars.length}',
          ),
          SizedBox(width: AppDimensions.spacingSm),
          AppDataChip(
            label: 'Cars In Stock',
            value: '${notifier.carsInStockCount}',
            valueColor: theme.colorScheme.tertiary,
          ),
          SizedBox(width: AppDimensions.spacingSm),
          AppDataChip(
            label: 'Total Parts',
            value: '${state.parts.length}',
          ),
          SizedBox(width: AppDimensions.spacingSm),
          AppDataChip(
            label: 'Low Stock Alerts',
            value: '${notifier.lowStockPartCount}',
            valueColor: theme.colorScheme.error,
          ),
        ],
      ),
    );
  }
}
