// lib/features/inventory/domain/enums/stock_status.dart
import 'package:flutter/material.dart';

enum StockStatus {
  inStock,
  lowStock,
  outOfStock;

  String get label {
    switch (this) {
      case StockStatus.inStock:
        return 'In Stock';
      case StockStatus.lowStock:
        return 'Low Stock';
      case StockStatus.outOfStock:
        return 'Out of Stock';
    }
  }

  Color colorToken(ColorScheme cs) {
    switch (this) {
      case StockStatus.inStock:
        return cs.tertiary;
      case StockStatus.lowStock:
        return cs.secondary;
      case StockStatus.outOfStock:
        return cs.error;
    }
  }
}
