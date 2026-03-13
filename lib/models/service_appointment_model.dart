enum AppointmentStatus { pending, inProgress, done }

class ServiceAppointmentModel {
  final String id;
  final String customerName;
  final String carId;
  final String serviceType;
  final DateTime scheduledAt;
  final AppointmentStatus status;
  final String technicianId;
  final String notes;

  const ServiceAppointmentModel({
    required this.id,
    required this.customerName,
    required this.carId,
    required this.serviceType,
    required this.scheduledAt,
    required this.status,
    required this.technicianId,
    required this.notes,
  });

  ServiceAppointmentModel copyWith({
    String? id,
    String? customerName,
    String? carId,
    String? serviceType,
    DateTime? scheduledAt,
    AppointmentStatus? status,
    String? technicianId,
    String? notes,
  }) {
    return ServiceAppointmentModel(
      id: id ?? this.id,
      customerName: customerName ?? this.customerName,
      carId: carId ?? this.carId,
      serviceType: serviceType ?? this.serviceType,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      status: status ?? this.status,
      technicianId: technicianId ?? this.technicianId,
      notes: notes ?? this.notes,
    );
  }
}
