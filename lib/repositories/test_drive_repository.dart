import 'package:automobile/models/test_drive_model.dart';

abstract class TestDriveRepository {
  Stream<List<TestDriveModel>> testDrivesStream();
  Future<void> addTestDrive(TestDriveModel testDrive);
  Future<void> updateTestDriveStatus(String id, TestDriveStatus status);
}
