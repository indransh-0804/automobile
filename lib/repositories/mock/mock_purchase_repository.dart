import 'dart:async';

import 'package:automobile/models/purchase_model.dart';
import 'package:automobile/repositories/purchase_repository.dart';
import 'package:automobile/repositories/mock/sample_data.dart';

class MockPurchaseRepository implements PurchaseRepository {
  final List<PurchaseModel> _purchases = List.from(SampleData.purchases);
  late final StreamController<List<PurchaseModel>> _controller;

  MockPurchaseRepository() {
    _controller = StreamController<List<PurchaseModel>>.broadcast(
      onListen: () => _emit(),
    );
  }

  void _emit() {
    _controller.add(List.unmodifiable(_purchases));
  }

  @override
  Stream<List<PurchaseModel>> purchasesStream() => _controller.stream;

  @override
  Future<void> addPurchase(PurchaseModel purchase) async {
    _purchases.insert(0, purchase);
    _emit();
  }
}
