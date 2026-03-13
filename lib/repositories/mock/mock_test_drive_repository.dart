import 'dart:async';

import 'package:automobile/models/test_drive_model.dart';
import 'package:automobile/repositories/test_drive_repository.dart';
import 'package:automobile/repositories/mock/sample_data.dart';

class MockTestDriveRepository implements TestDriveRepository {
  final List<TestDriveModel> _testDrives = List.from(SampleData.testDrives);
  late final StreamController<List<TestDriveModel>> _controller;

  MockTestDriveRepository() {
    _controller = StreamController<List<TestDriveModel>>.broadcast(
      onListen: () => _emit(),
    );
  }

  void _emit() {
    _controller.add(List.unmodifiable(_testDrives));
  }

  @override
  Stream<List<TestDriveModel>> testDrivesStream() => _controller.stream;

  @override
  Future<void> addTestDrive(TestDriveModel testDrive) async {
    _testDrives.insert(0, testDrive);
    _emit();
  }

  @override
  Future<void> updateTestDriveStatus(String id, TestDriveStatus status) async {
    final index = _testDrives.indexWhere((t) => t.id == id);
    if (index != -1) {
      final td = _testDrives[index];
      _testDrives[index] = TestDriveModel(
        id: td.id,
        customerId: td.customerId,
        customerName: td.customerName,
        carId: td.carId,
        carName: td.carName,
        scheduledAt: td.scheduledAt,
        employeeId: td.employeeId,
        status: status,
        notes: td.notes,
      );
      _emit();
    }
  }
}
