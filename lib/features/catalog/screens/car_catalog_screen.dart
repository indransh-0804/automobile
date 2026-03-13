import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:automobile/core/constants/app_constants.dart';
import 'package:automobile/providers/car_provider.dart';
import 'package:automobile/features/catalog/widgets/catalog_car_card.dart';
import 'package:automobile/widgets/display/app_loading_indicator.dart';
import 'package:automobile/widgets/display/app_empty_state.dart';

class CarCatalogScreen extends ConsumerWidget {
  const CarCatalogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carsAsync = ref.watch(carsProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth > 600 ? 3 : 2;

    return Scaffold(
      appBar: AppBar(title: const Text('Car Catalog')),
      body: carsAsync.when(
        data: (cars) {
          if (cars.isEmpty) {
            return const AppEmptyState(
              icon: Icons.directions_car,
              title: 'No Cars Available',
              subtitle: 'Cars will appear here once added to inventory.',
            );
          }
          return GridView.builder(
            padding: EdgeInsets.all(kBaseUnit * 2),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: 0.75,
              crossAxisSpacing: kBaseUnit,
              mainAxisSpacing: kBaseUnit,
            ),
            itemCount: cars.length,
            itemBuilder: (context, index) =>
                CatalogCarCard(car: cars[index]),
          );
        },
        loading: () => const AppLoadingIndicator(),
        error: (error, _) => Center(child: Text(error.toString())),
      ),
    );
  }
}
