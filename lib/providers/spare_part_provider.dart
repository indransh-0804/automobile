import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:automobile/models/spare_part_model.dart';
import 'package:automobile/data/mock_data.dart';

final sparePartsProvider = Provider<List<SparePartModel>>((ref) {
  return MockData.spareParts;
});

final lowStockPartsProvider = Provider<List<SparePartModel>>((ref) {
  final parts = ref.watch(sparePartsProvider);
  return parts
      .where((part) => part.stockCount <= part.lowStockThreshold)
      .toList();
});
