import 'package:automobile/core/services/firestore_service.dart';
import 'package:automobile/models/spare_part_model.dart';
import 'package:automobile/repositories/spare_part_repository.dart';

class FirestoreSparePartRepository implements SparePartRepository {
  final FirestoreService _service;

  FirestoreSparePartRepository(this._service);

  @override
  Stream<List<SparePartModel>> sparePartsStream() =>
      _service.sparePartsStream();

  @override
  Stream<List<SparePartModel>> lowStockPartsStream() =>
      _service.lowStockPartsStream();

  @override
  Future<void> addSparePart(SparePartModel part) =>
      _service.addSparePart(part);

  @override
  Future<void> updateSparePart(SparePartModel part) =>
      _service.updateSparePart(part);

  @override
  Future<void> deleteSparePart(String id) => _service.deleteSparePart(id);
}
