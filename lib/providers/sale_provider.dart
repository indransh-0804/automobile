import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:automobile/core/services/firestore_service.dart';
import 'package:automobile/models/sale_model.dart';

final salesProvider = StreamProvider<List<SaleModel>>((ref) {
  final firestoreService = ref.watch(firestoreServiceProvider);
  return firestoreService.salesStream();
});

final saleControllerProvider = Provider<SaleController>((ref) {
  return SaleController(ref);
});

class SaleController {
  final Ref _ref;

  SaleController(this._ref);

  Future<void> addSale(SaleModel sale) async {
    final service = _ref.read(firestoreServiceProvider);
    await service.addSale(sale);
  }
}
