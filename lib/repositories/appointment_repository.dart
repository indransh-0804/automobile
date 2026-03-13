import 'package:automobile/models/service_appointment_model.dart';

abstract class AppointmentRepository {
  Stream<List<ServiceAppointmentModel>> appointmentsStream();
  Future<void> addAppointment(ServiceAppointmentModel appointment);
  Future<void> updateAppointmentStatus(String id, AppointmentStatus status);
}
