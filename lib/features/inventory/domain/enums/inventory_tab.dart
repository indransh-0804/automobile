// lib/features/inventory/domain/enums/inventory_tab.dart
enum InventoryTab {
  cars,
  parts;

  String get label {
    switch (this) {
      case InventoryTab.cars:
        return 'Cars';
      case InventoryTab.parts:
        return 'Parts';
    }
  }
}
