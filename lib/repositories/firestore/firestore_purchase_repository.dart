import 'package:automobile/core/services/firestore_service.dart';
import 'package:automobile/models/purchase_model.dart';
import 'package:automobile/repositories/purchase_repository.dart';

class FirestorePurchaseRepository implements PurchaseRepository {
  final FirestoreService _service;

  FirestorePurchaseRepository(this._service);

  @override
  Stream<List<PurchaseModel>> purchasesStream() =>
      _service.purchasesStream();

  @override
  Future<void> addPurchase(PurchaseModel purchase) =>
      _service.addPurchase(purchase);
}
