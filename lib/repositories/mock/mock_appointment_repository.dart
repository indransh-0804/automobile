import 'dart:async';

import 'package:automobile/models/service_appointment_model.dart';
import 'package:automobile/repositories/appointment_repository.dart';
import 'package:automobile/repositories/mock/sample_data.dart';

class MockAppointmentRepository implements AppointmentRepository {
  final List<ServiceAppointmentModel> _appointments =
      List.from(SampleData.appointments);
  late final StreamController<List<ServiceAppointmentModel>> _controller;

  MockAppointmentRepository() {
    _controller = StreamController<List<ServiceAppointmentModel>>.broadcast(
      onListen: () => _emit(),
    );
  }

  void _emit() {
    _controller.add(List.unmodifiable(_appointments));
  }

  @override
  Stream<List<ServiceAppointmentModel>> appointmentsStream() =>
      _controller.stream;

  @override
  Future<void> addAppointment(ServiceAppointmentModel appointment) async {
    _appointments.insert(0, appointment);
    _emit();
  }

  @override
  Future<void> updateAppointmentStatus(
      String id, AppointmentStatus status) async {
    final index = _appointments.indexWhere((a) => a.id == id);
    if (index != -1) {
      final apt = _appointments[index];
      _appointments[index] = ServiceAppointmentModel(
        id: apt.id,
        customerId: apt.customerId,
        customerName: apt.customerName,
        carId: apt.carId,
        serviceType: apt.serviceType,
        scheduledAt: apt.scheduledAt,
        status: status,
        technicianId: apt.technicianId,
        notes: apt.notes,
      );
      _emit();
    }
  }
}
