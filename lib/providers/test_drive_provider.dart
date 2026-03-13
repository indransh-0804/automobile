import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:automobile/models/test_drive_model.dart';
import 'package:automobile/providers/repository_providers.dart';

final testDrivesProvider = StreamProvider<List<TestDriveModel>>((ref) {
  final repository = ref.watch(testDriveRepositoryProvider);
  return repository.testDrivesStream();
});

final testDriveControllerProvider = Provider<TestDriveController>((ref) {
  return TestDriveController(ref);
});

class TestDriveController {
  final Ref _ref;

  TestDriveController(this._ref);

  Future<void> addTestDrive(TestDriveModel testDrive) async {
    final repository = _ref.read(testDriveRepositoryProvider);
    await repository.addTestDrive(testDrive);
  }

  Future<void> updateStatus(String id, TestDriveStatus status) async {
    final repository = _ref.read(testDriveRepositoryProvider);
    await repository.updateTestDriveStatus(id, status);
  }
}
