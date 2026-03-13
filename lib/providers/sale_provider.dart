import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:automobile/models/sale_model.dart';
import 'package:automobile/data/mock_data.dart';

final salesProvider = Provider<List<SaleModel>>((ref) {
  return MockData.sales;
});

final recentSalesProvider = Provider<List<SaleModel>>((ref) {
  final sales = ref.watch(salesProvider);
  final sorted = List<SaleModel>.from(sales)
    ..sort((a, b) => b.date.compareTo(a.date));
  return sorted.take(5).toList();
});
