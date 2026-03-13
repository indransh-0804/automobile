import 'package:cloud_firestore/cloud_firestore.dart';

enum AppointmentStatus { pending, inProgress, done }

class ServiceAppointmentModel {
  final String id;
  final String customerId;
  final String customerName;
  final String carId;
  final String serviceType;
  final DateTime scheduledAt;
  final AppointmentStatus status;
  final String technicianId;
  final String notes;

  ServiceAppointmentModel({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.carId,
    required this.serviceType,
    required this.scheduledAt,
    required this.status,
    required this.technicianId,
    required this.notes,
  });

  factory ServiceAppointmentModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ServiceAppointmentModel(
      id: doc.id,
      customerId: data['customerId'] as String,
      customerName: data['customerName'] as String,
      carId: data['carId'] as String,
      serviceType: data['serviceType'] as String,
      scheduledAt: (data['scheduledAt'] as Timestamp).toDate(),
      status: AppointmentStatus.values.firstWhere(
        (e) => e.name == data['status'],
        orElse: () => AppointmentStatus.pending,
      ),
      technicianId: data['technicianId'] as String,
      notes: data['notes'] as String? ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'customerId': customerId,
      'customerName': customerName,
      'carId': carId,
      'serviceType': serviceType,
      'scheduledAt': Timestamp.fromDate(scheduledAt),
      'status': status.name,
      'technicianId': technicianId,
      'notes': notes,
    };
  }
}
