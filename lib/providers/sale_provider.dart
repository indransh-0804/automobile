import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:automobile/models/sale_model.dart';
import 'package:automobile/providers/repository_providers.dart';

final salesProvider = StreamProvider<List<SaleModel>>((ref) {
  final repository = ref.watch(saleRepositoryProvider);
  return repository.salesStream();
});

final saleControllerProvider = Provider<SaleController>((ref) {
  return SaleController(ref);
});

class SaleController {
  final Ref _ref;

  SaleController(this._ref);

  Future<void> addSale(SaleModel sale) async {
    final repository = _ref.read(saleRepositoryProvider);
    await repository.addSale(sale);
  }
}
