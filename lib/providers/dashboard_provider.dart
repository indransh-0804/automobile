import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:automobile/providers/car_provider.dart';
import 'package:automobile/providers/spare_part_provider.dart';
import 'package:automobile/providers/sale_provider.dart';
import 'package:automobile/providers/loan_provider.dart';
import 'package:automobile/providers/appointment_provider.dart';
import 'package:automobile/models/spare_part_model.dart';
import 'package:automobile/models/sale_model.dart';
import 'package:automobile/models/loan_model.dart';
import 'package:automobile/models/service_appointment_model.dart';

final totalCarsProvider = Provider<int>((ref) {
  final cars = ref.watch(carsProvider);
  return cars.when(
    data: (list) => list.length,
    loading: () => 0,
    error: (_, __) => 0,
  );
});

final totalSparePartsProvider = Provider<int>((ref) {
  final parts = ref.watch(sparePartsProvider);
  return parts.when(
    data: (list) => list.length,
    loading: () => 0,
    error: (_, __) => 0,
  );
});

final dashboardLowStockPartsProvider =
    Provider<List<SparePartModel>>((ref) {
  final parts = ref.watch(lowStockPartsProvider);
  return parts.when(
    data: (list) => list,
    loading: () => [],
    error: (_, __) => [],
  );
});

final monthlySalesProvider = Provider<double>((ref) {
  final sales = ref.watch(salesProvider);
  return sales.when(
    data: (list) {
      final now = DateTime.now();
      final monthlySales = list.where((s) =>
          s.date.month == now.month && s.date.year == now.year);
      return monthlySales.fold<double>(0, (sum, s) => sum + s.amount);
    },
    loading: () => 0,
    error: (_, __) => 0,
  );
});

final activeLoansCountProvider = Provider<int>((ref) {
  final loans = ref.watch(loansProvider);
  return loans.when(
    data: (list) => list.where((l) => l.status == LoanStatus.active).length,
    loading: () => 0,
    error: (_, __) => 0,
  );
});

final todayAppointmentsCountProvider = Provider<int>((ref) {
  final appointments = ref.watch(appointmentsProvider);
  return appointments.when(
    data: (list) {
      final now = DateTime.now();
      return list
          .where((a) =>
              a.scheduledAt.year == now.year &&
              a.scheduledAt.month == now.month &&
              a.scheduledAt.day == now.day)
          .length;
    },
    loading: () => 0,
    error: (_, __) => 0,
  );
});

final todayAppointmentsProvider =
    Provider<List<ServiceAppointmentModel>>((ref) {
  final appointments = ref.watch(appointmentsProvider);
  return appointments.when(
    data: (list) {
      final now = DateTime.now();
      return list
          .where((a) =>
              a.scheduledAt.year == now.year &&
              a.scheduledAt.month == now.month &&
              a.scheduledAt.day == now.day)
          .toList();
    },
    loading: () => [],
    error: (_, __) => [],
  );
});

final recentSalesProvider = Provider<List<SaleModel>>((ref) {
  final sales = ref.watch(salesProvider);
  return sales.when(
    data: (list) => list.take(5).toList(),
    loading: () => [],
    error: (_, __) => [],
  );
});
