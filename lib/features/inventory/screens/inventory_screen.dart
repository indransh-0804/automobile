import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:automobile/core/router/route_names.dart';
import 'package:automobile/core/constants/app_constants.dart';
import 'package:automobile/providers/car_provider.dart';
import 'package:automobile/providers/spare_part_provider.dart';
import 'package:automobile/features/inventory/widgets/car_card.dart';
import 'package:automobile/features/inventory/widgets/spare_part_tile.dart';
import 'package:automobile/widgets/display/app_loading_indicator.dart';
import 'package:automobile/widgets/display/app_empty_state.dart';

class InventoryScreen extends ConsumerStatefulWidget {
  const InventoryScreen({super.key});

  @override
  ConsumerState<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends ConsumerState<InventoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final carsAsync = ref.watch(carsProvider);
    final sparePartsAsync = ref.watch(sparePartsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Cars'),
            Tab(text: 'Spare Parts'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          carsAsync.when(
            data: (cars) {
              if (cars.isEmpty) {
                return const AppEmptyState(
                  icon: Icons.directions_car,
                  title: 'No Cars',
                  subtitle: 'Add your first car to the inventory.',
                );
              }
              return ListView.builder(
                padding: EdgeInsets.all(kBaseUnit * 2),
                itemCount: cars.length,
                itemBuilder: (context, index) => CarCard(car: cars[index]),
              );
            },
            loading: () => const AppLoadingIndicator(),
            error: (error, _) => Center(child: Text(error.toString())),
          ),
          sparePartsAsync.when(
            data: (parts) {
              if (parts.isEmpty) {
                return const AppEmptyState(
                  icon: Icons.settings,
                  title: 'No Spare Parts',
                  subtitle: 'Add spare parts to track inventory.',
                );
              }
              return ListView.builder(
                padding: EdgeInsets.all(kBaseUnit * 2),
                itemCount: parts.length,
                itemBuilder: (context, index) =>
                    SparePartTile(sparePart: parts[index]),
              );
            },
            loading: () => const AppLoadingIndicator(),
            error: (error, _) => Center(child: Text(error.toString())),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_tabController.index == 0) {
            context.goNamed(RouteNames.addCar);
          } else {
            context.goNamed(RouteNames.addSparePart);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
