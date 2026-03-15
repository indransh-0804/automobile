// lib/features/inventory/presentation/widgets/car_inventory_list.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_dimensions.dart';
import '../../../../shared/widgets/app_empty_state.dart';
import '../providers/inventory_provider.dart';
import 'car_inventory_card.dart';

class CarInventoryList extends ConsumerWidget {
  const CarInventoryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(inventoryProvider.notifier);
    final cars = notifier.filteredCars;

    if (cars.isEmpty) {
      return const AppEmptyState(
        icon: Icons.directions_car_outlined,
        title: 'No Cars Found',
        subtitle: 'Try adjusting your search or filter criteria.',
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacingMd,
      ),
      itemCount: cars.length,
      separatorBuilder: (_, __) =>
          SizedBox(height: AppDimensions.spacingSm),
      itemBuilder: (context, index) => CarInventoryCard(car: cars[index]),
    );
  }
}
