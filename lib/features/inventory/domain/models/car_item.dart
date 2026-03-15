// lib/features/inventory/domain/models/car_item.dart
import 'package:equatable/equatable.dart';

import '../enums/stock_status.dart';

class CarItem extends Equatable {
  final String id;
  final String make;
  final String model;
  final int year;
  final String variant;
  final String color;
  final String vin;
  final double purchasePrice;
  final double sellingPrice;
  final StockStatus stockStatus;
  final int mileage;
  final DateTime dateAdded;
  final String imageUrl;

  const CarItem({
    required this.id,
    required this.make,
    required this.model,
    required this.year,
    required this.variant,
    required this.color,
    required this.vin,
    required this.purchasePrice,
    required this.sellingPrice,
    required this.stockStatus,
    required this.mileage,
    required this.dateAdded,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [
        id,
        make,
        model,
        year,
        variant,
        color,
        vin,
        purchasePrice,
        sellingPrice,
        stockStatus,
        mileage,
        dateAdded,
        imageUrl,
      ];
}
