// lib/features/inventory/presentation/widgets/inventory_filter_bar.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_dimensions.dart';
import '../../../../shared/widgets/app_search_bar.dart';
import '../../domain/enums/stock_status.dart';
import '../providers/inventory_provider.dart';

class InventoryFilterBar extends ConsumerWidget {
  const InventoryFilterBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statusFilter = ref.watch(inventoryProvider).statusFilter;
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacingMd,
        vertical: AppDimensions.spacingSm,
      ),
      child: Row(
        children: [
          Expanded(
            child: AppSearchBar(
              hint: 'Search inventory...',
              onChanged: (query) =>
                  ref.read(inventoryProvider.notifier).setSearch(query),
            ),
          ),
          SizedBox(width: AppDimensions.spacingSm),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.spacingSm,
            ),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<StockStatus?>(
                value: statusFilter,
                hint: Text(
                  'Status',
                  style: theme.textTheme.bodySmall,
                ),
                icon: Icon(
                  Icons.filter_list,
                  size: AppDimensions.iconSizeSm,
                ),
                items: [
                  DropdownMenuItem<StockStatus?>(
                    value: null,
                    child: Text(
                      'All',
                      style: theme.textTheme.bodySmall,
                    ),
                  ),
                  ...StockStatus.values.map(
                    (status) => DropdownMenuItem<StockStatus?>(
                      value: status,
                      child: Text(
                        status.label,
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                  ),
                ],
                onChanged: (value) =>
                    ref.read(inventoryProvider.notifier).setStatusFilter(value),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
