import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:automobile/core/services/firestore_service.dart';
import 'package:automobile/models/test_drive_model.dart';

final testDrivesProvider = StreamProvider<List<TestDriveModel>>((ref) {
  final firestoreService = ref.watch(firestoreServiceProvider);
  return firestoreService.testDrivesStream();
});

final testDriveControllerProvider = Provider<TestDriveController>((ref) {
  return TestDriveController(ref);
});

class TestDriveController {
  final Ref _ref;

  TestDriveController(this._ref);

  Future<void> addTestDrive(TestDriveModel testDrive) async {
    final service = _ref.read(firestoreServiceProvider);
    await service.addTestDrive(testDrive);
  }

  Future<void> updateStatus(String id, TestDriveStatus status) async {
    final service = _ref.read(firestoreServiceProvider);
    await service.updateTestDriveStatus(id, status);
  }
}
