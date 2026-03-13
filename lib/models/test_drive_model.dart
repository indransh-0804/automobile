import 'package:cloud_firestore/cloud_firestore.dart';

enum TestDriveStatus { scheduled, completed, cancelled }

class TestDriveModel {
  final String id;
  final String customerId;
  final String customerName;
  final String carId;
  final String carName;
  final DateTime scheduledAt;
  final String employeeId;
  final TestDriveStatus status;
  final String notes;

  TestDriveModel({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.carId,
    required this.carName,
    required this.scheduledAt,
    required this.employeeId,
    required this.status,
    required this.notes,
  });

  factory TestDriveModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TestDriveModel(
      id: doc.id,
      customerId: data['customerId'] as String,
      customerName: data['customerName'] as String,
      carId: data['carId'] as String,
      carName: data['carName'] as String,
      scheduledAt: (data['scheduledAt'] as Timestamp).toDate(),
      employeeId: data['employeeId'] as String,
      status: TestDriveStatus.values.firstWhere(
        (e) => e.name == data['status'],
        orElse: () => TestDriveStatus.scheduled,
      ),
      notes: data['notes'] as String? ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'customerId': customerId,
      'customerName': customerName,
      'carId': carId,
      'carName': carName,
      'scheduledAt': Timestamp.fromDate(scheduledAt),
      'employeeId': employeeId,
      'status': status.name,
      'notes': notes,
    };
  }
}
