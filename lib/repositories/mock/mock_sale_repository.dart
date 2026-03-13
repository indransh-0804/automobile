import 'dart:async';

import 'package:automobile/models/sale_model.dart';
import 'package:automobile/repositories/sale_repository.dart';
import 'package:automobile/repositories/mock/sample_data.dart';

class MockSaleRepository implements SaleRepository {
  final List<SaleModel> _sales = List.from(SampleData.sales);
  late final StreamController<List<SaleModel>> _controller;

  MockSaleRepository() {
    _controller = StreamController<List<SaleModel>>.broadcast(
      onListen: () => _emit(),
    );
  }

  void _emit() {
    _controller.add(List.unmodifiable(_sales));
  }

  @override
  Stream<List<SaleModel>> salesStream() => _controller.stream;

  @override
  Future<void> addSale(SaleModel sale) async {
    _sales.insert(0, sale);
    _emit();
  }
}
