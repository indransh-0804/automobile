import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:automobile/core/services/firestore_service.dart';
import 'package:automobile/models/purchase_model.dart';

final purchasesProvider = StreamProvider<List<PurchaseModel>>((ref) {
  final firestoreService = ref.watch(firestoreServiceProvider);
  return firestoreService.purchasesStream();
});

final purchaseControllerProvider = Provider<PurchaseController>((ref) {
  return PurchaseController(ref);
});

class PurchaseController {
  final Ref _ref;

  PurchaseController(this._ref);

  Future<void> addPurchase(PurchaseModel purchase) async {
    final service = _ref.read(firestoreServiceProvider);
    await service.addPurchase(purchase);
  }
}
