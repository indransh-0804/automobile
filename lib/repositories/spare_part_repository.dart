import 'package:automobile/models/spare_part_model.dart';

abstract class SparePartRepository {
  Stream<List<SparePartModel>> sparePartsStream();
  Stream<List<SparePartModel>> lowStockPartsStream();
  Future<void> addSparePart(SparePartModel part);
  Future<void> updateSparePart(SparePartModel part);
  Future<void> deleteSparePart(String id);
}
