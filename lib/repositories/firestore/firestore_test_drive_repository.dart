import 'package:automobile/core/services/firestore_service.dart';
import 'package:automobile/models/test_drive_model.dart';
import 'package:automobile/repositories/test_drive_repository.dart';

class FirestoreTestDriveRepository implements TestDriveRepository {
  final FirestoreService _service;

  FirestoreTestDriveRepository(this._service);

  @override
  Stream<List<TestDriveModel>> testDrivesStream() =>
      _service.testDrivesStream();

  @override
  Future<void> addTestDrive(TestDriveModel testDrive) =>
      _service.addTestDrive(testDrive);

  @override
  Future<void> updateTestDriveStatus(String id, TestDriveStatus status) =>
      _service.updateTestDriveStatus(id, status);
}
