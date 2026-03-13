import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:automobile/models/service_appointment_model.dart';
import 'package:automobile/providers/repository_providers.dart';

final appointmentsProvider =
    StreamProvider<List<ServiceAppointmentModel>>((ref) {
  final repository = ref.watch(appointmentRepositoryProvider);
  return repository.appointmentsStream();
});

final appointmentControllerProvider =
    Provider<AppointmentController>((ref) {
  return AppointmentController(ref);
});

class AppointmentController {
  final Ref _ref;

  AppointmentController(this._ref);

  Future<void> addAppointment(ServiceAppointmentModel appointment) async {
    final repository = _ref.read(appointmentRepositoryProvider);
    await repository.addAppointment(appointment);
  }

  Future<void> updateStatus(String id, AppointmentStatus status) async {
    final repository = _ref.read(appointmentRepositoryProvider);
    await repository.updateAppointmentStatus(id, status);
  }
}
