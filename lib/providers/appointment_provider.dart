import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:automobile/core/services/firestore_service.dart';
import 'package:automobile/models/service_appointment_model.dart';

final appointmentsProvider =
    StreamProvider<List<ServiceAppointmentModel>>((ref) {
  final firestoreService = ref.watch(firestoreServiceProvider);
  return firestoreService.appointmentsStream();
});

final appointmentControllerProvider =
    Provider<AppointmentController>((ref) {
  return AppointmentController(ref);
});

class AppointmentController {
  final Ref _ref;

  AppointmentController(this._ref);

  Future<void> addAppointment(ServiceAppointmentModel appointment) async {
    final service = _ref.read(firestoreServiceProvider);
    await service.addAppointment(appointment);
  }

  Future<void> updateStatus(String id, AppointmentStatus status) async {
    final service = _ref.read(firestoreServiceProvider);
    await service.updateAppointmentStatus(id, status);
  }
}
