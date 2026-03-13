import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:automobile/models/service_appointment_model.dart';
import 'package:automobile/data/mock_data.dart';

final appointmentsProvider = Provider<List<ServiceAppointmentModel>>((ref) {
  return MockData.appointments;
});

final todayAppointmentsProvider = Provider<List<ServiceAppointmentModel>>((ref) {
  final appointments = ref.watch(appointmentsProvider);
  final now = DateTime.now();
  return appointments
      .where((apt) =>
          apt.scheduledAt.year == now.year &&
          apt.scheduledAt.month == now.month &&
          apt.scheduledAt.day == now.day)
      .toList();
});
