import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:automobile/models/spare_part_model.dart';
import 'package:automobile/providers/repository_providers.dart';

final sparePartsProvider = StreamProvider<List<SparePartModel>>((ref) {
  final repository = ref.watch(sparePartRepositoryProvider);
  return repository.sparePartsStream();
});

final lowStockPartsProvider = StreamProvider<List<SparePartModel>>((ref) {
  final repository = ref.watch(sparePartRepositoryProvider);
  return repository.lowStockPartsStream();
});

final sparePartControllerProvider = Provider<SparePartController>((ref) {
  return SparePartController(ref);
});

class SparePartController {
  final Ref _ref;

  SparePartController(this._ref);

  Future<void> addSparePart(SparePartModel part) async {
    final repository = _ref.read(sparePartRepositoryProvider);
    await repository.addSparePart(part);
  }

  Future<void> updateSparePart(SparePartModel part) async {
    final repository = _ref.read(sparePartRepositoryProvider);
    await repository.updateSparePart(part);
  }

  Future<void> deleteSparePart(String id) async {
    final repository = _ref.read(sparePartRepositoryProvider);
    await repository.deleteSparePart(id);
  }
}
