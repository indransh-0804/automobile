// lib/features/inventory/presentation/widgets/part_inventory_list.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_dimensions.dart';
import '../../../../shared/widgets/app_empty_state.dart';
import '../providers/inventory_provider.dart';
import 'part_inventory_card.dart';

class PartInventoryList extends ConsumerWidget {
  const PartInventoryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(inventoryProvider.notifier);
    final parts = notifier.filteredParts;

    if (parts.isEmpty) {
      return const AppEmptyState(
        icon: Icons.settings_outlined,
        title: 'No Parts Found',
        subtitle: 'Try adjusting your search or filter criteria.',
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacingMd,
      ),
      itemCount: parts.length,
      separatorBuilder: (_, __) =>
          SizedBox(height: AppDimensions.spacingSm),
      itemBuilder: (context, index) =>
          PartInventoryCard(part: parts[index]),
    );
  }
}
