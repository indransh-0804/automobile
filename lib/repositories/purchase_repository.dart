import 'package:automobile/models/purchase_model.dart';

abstract class PurchaseRepository {
  Stream<List<PurchaseModel>> purchasesStream();
  Future<void> addPurchase(PurchaseModel purchase);
}
