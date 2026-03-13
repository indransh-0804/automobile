import 'dart:async';

import 'package:automobile/models/spare_part_model.dart';
import 'package:automobile/repositories/spare_part_repository.dart';
import 'package:automobile/repositories/mock/sample_data.dart';

class MockSparePartRepository implements SparePartRepository {
  final List<SparePartModel> _parts = List.from(SampleData.spareParts);
  late final StreamController<List<SparePartModel>> _controller;

  MockSparePartRepository() {
    _controller = StreamController<List<SparePartModel>>.broadcast(
      onListen: () => _emit(),
    );
  }

  void _emit() {
    _controller.add(List.unmodifiable(_parts));
  }

  @override
  Stream<List<SparePartModel>> sparePartsStream() => _controller.stream;

  @override
  Stream<List<SparePartModel>> lowStockPartsStream() {
    return sparePartsStream().map(
      (parts) =>
          parts.where((p) => p.stockCount <= p.lowStockThreshold).toList(),
    );
  }

  @override
  Future<void> addSparePart(SparePartModel part) async {
    _parts.insert(0, part);
    _emit();
  }

  @override
  Future<void> updateSparePart(SparePartModel part) async {
    final index = _parts.indexWhere((p) => p.id == part.id);
    if (index != -1) {
      _parts[index] = part;
      _emit();
    }
  }

  @override
  Future<void> deleteSparePart(String id) async {
    _parts.removeWhere((p) => p.id == id);
    _emit();
  }
}
