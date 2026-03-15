// lib/features/inventory/domain/models/part_item.dart
import 'package:equatable/equatable.dart';

import '../enums/stock_status.dart';

class PartItem extends Equatable {
  final String id;
  final String name;
  final String partNumber;
  final String category;
  final List<String> compatibleModels;
  final int quantityInStock;
  final int reorderLevel;
  final double unitCost;
  final double sellingPrice;
  final StockStatus stockStatus;
  final String supplier;
  final DateTime dateAdded;

  const PartItem({
    required this.id,
    required this.name,
    required this.partNumber,
    required this.category,
    required this.compatibleModels,
    required this.quantityInStock,
    required this.reorderLevel,
    required this.unitCost,
    required this.sellingPrice,
    required this.stockStatus,
    required this.supplier,
    required this.dateAdded,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        partNumber,
        category,
        compatibleModels,
        quantityInStock,
        reorderLevel,
        unitCost,
        sellingPrice,
        stockStatus,
        supplier,
        dateAdded,
      ];
}
