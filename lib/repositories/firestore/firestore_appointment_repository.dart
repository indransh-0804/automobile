import 'package:automobile/core/services/firestore_service.dart';
import 'package:automobile/models/service_appointment_model.dart';
import 'package:automobile/repositories/appointment_repository.dart';

class FirestoreAppointmentRepository implements AppointmentRepository {
  final FirestoreService _service;

  FirestoreAppointmentRepository(this._service);

  @override
  Stream<List<ServiceAppointmentModel>> appointmentsStream() =>
      _service.appointmentsStream();

  @override
  Future<void> addAppointment(ServiceAppointmentModel appointment) =>
      _service.addAppointment(appointment);

  @override
  Future<void> updateAppointmentStatus(String id, AppointmentStatus status) =>
      _service.updateAppointmentStatus(id, status);
}
