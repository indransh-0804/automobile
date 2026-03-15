// lib/features/inventory/presentation/providers/inventory_provider.dart
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/inventory_repository.dart';
import '../../domain/enums/inventory_tab.dart';
import '../../domain/enums/stock_status.dart';
import '../../domain/models/car_item.dart';
import '../../domain/models/part_item.dart';

class InventoryState extends Equatable {
  final List<CarItem> cars;
  final List<PartItem> parts;
  final InventoryTab activeTab;
  final String searchQuery;
  final StockStatus? statusFilter;

  const InventoryState({
    this.cars = const [],
    this.parts = const [],
    this.activeTab = InventoryTab.cars,
    this.searchQuery = '',
    this.statusFilter,
  });

  InventoryState copyWith({
    List<CarItem>? cars,
    List<PartItem>? parts,
    InventoryTab? activeTab,
    String? searchQuery,
    StockStatus? Function()? statusFilter,
  }) {
    return InventoryState(
      cars: cars ?? this.cars,
      parts: parts ?? this.parts,
      activeTab: activeTab ?? this.activeTab,
      searchQuery: searchQuery ?? this.searchQuery,
      statusFilter: statusFilter != null ? statusFilter() : this.statusFilter,
    );
  }

  @override
  List<Object?> get props => [cars, parts, activeTab, searchQuery, statusFilter];
}

class InventoryNotifier extends StateNotifier<InventoryState> {
  InventoryNotifier() : super(const InventoryState()) {
    _loadData();
  }

  final _repository = InventoryRepository();

  void _loadData() {
    state = state.copyWith(
      cars: _repository.getCars(),
      parts: _repository.getParts(),
    );
  }

  List<CarItem> get filteredCars {
    var cars = state.cars;

    if (state.searchQuery.isNotEmpty) {
      final query = state.searchQuery.toLowerCase();
      cars = cars.where((car) {
        return car.make.toLowerCase().contains(query) ||
            car.model.toLowerCase().contains(query) ||
            car.variant.toLowerCase().contains(query) ||
            car.vin.toLowerCase().contains(query);
      }).toList();
    }

    if (state.statusFilter != null) {
      cars = cars.where((car) => car.stockStatus == state.statusFilter).toList();
    }

    return cars;
  }

  List<PartItem> get filteredParts {
    var parts = state.parts;

    if (state.searchQuery.isNotEmpty) {
      final query = state.searchQuery.toLowerCase();
      parts = parts.where((part) {
        return part.name.toLowerCase().contains(query) ||
            part.partNumber.toLowerCase().contains(query) ||
            part.category.toLowerCase().contains(query) ||
            part.supplier.toLowerCase().contains(query);
      }).toList();
    }

    if (state.statusFilter != null) {
      parts = parts
          .where((part) => part.stockStatus == state.statusFilter)
          .toList();
    }

    return parts;
  }

  double get totalCarValue {
    return state.cars.fold(0.0, (sum, car) => sum + car.purchasePrice);
  }

  int get lowStockPartCount {
    return state.parts
        .where((part) => part.stockStatus == StockStatus.lowStock ||
            part.stockStatus == StockStatus.outOfStock)
        .length;
  }

  int get carsInStockCount {
    return state.cars
        .where((car) => car.stockStatus == StockStatus.inStock)
        .length;
  }

  void setTab(InventoryTab tab) {
    state = state.copyWith(activeTab: tab);
  }

  void setSearch(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void setStatusFilter(StockStatus? filter) {
    state = state.copyWith(statusFilter: () => filter);
  }

  void addCar(CarItem car) {
    state = state.copyWith(cars: [...state.cars, car]);
  }

  void addPart(PartItem part) {
    state = state.copyWith(parts: [...state.parts, part]);
  }
}

final inventoryProvider =
    StateNotifierProvider<InventoryNotifier, InventoryState>(
  (ref) => InventoryNotifier(),
);
