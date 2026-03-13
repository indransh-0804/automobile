import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:automobile/models/purchase_model.dart';
import 'package:automobile/providers/repository_providers.dart';

final purchasesProvider = StreamProvider<List<PurchaseModel>>((ref) {
  final repository = ref.watch(purchaseRepositoryProvider);
  return repository.purchasesStream();
});

final purchaseControllerProvider = Provider<PurchaseController>((ref) {
  return PurchaseController(ref);
});

class PurchaseController {
  final Ref _ref;

  PurchaseController(this._ref);

  Future<void> addPurchase(PurchaseModel purchase) async {
    final repository = _ref.read(purchaseRepositoryProvider);
    await repository.addPurchase(purchase);
  }
}
