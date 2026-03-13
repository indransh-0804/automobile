import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:automobile/core/services/firestore_service.dart';
import 'package:automobile/models/spare_part_model.dart';

final sparePartsProvider = StreamProvider<List<SparePartModel>>((ref) {
  final firestoreService = ref.watch(firestoreServiceProvider);
  return firestoreService.sparePartsStream();
});

final lowStockPartsProvider = StreamProvider<List<SparePartModel>>((ref) {
  final firestoreService = ref.watch(firestoreServiceProvider);
  return firestoreService.lowStockPartsStream();
});

final sparePartControllerProvider = Provider<SparePartController>((ref) {
  return SparePartController(ref);
});

class SparePartController {
  final Ref _ref;

  SparePartController(this._ref);

  Future<void> addSparePart(SparePartModel part) async {
    final service = _ref.read(firestoreServiceProvider);
    await service.addSparePart(part);
  }

  Future<void> updateSparePart(SparePartModel part) async {
    final service = _ref.read(firestoreServiceProvider);
    await service.updateSparePart(part);
  }

  Future<void> deleteSparePart(String id) async {
    final service = _ref.read(firestoreServiceProvider);
    await service.deleteSparePart(id);
  }
}
