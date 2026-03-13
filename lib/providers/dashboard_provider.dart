import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:automobile/models/spare_part_model.dart';
import 'package:automobile/models/sale_model.dart';
import 'package:automobile/models/service_appointment_model.dart';
import 'package:automobile/providers/car_provider.dart';
import 'package:automobile/providers/spare_part_provider.dart';
import 'package:automobile/providers/sale_provider.dart';
import 'package:automobile/providers/loan_provider.dart';
import 'package:automobile/providers/appointment_provider.dart';

class DashboardData {
  final int totalCars;
  final int totalSpareParts;
  final List<SparePartModel> lowStockParts;
  final double monthlySalesTotal;
  final int activeLoansCount;
  final List<ServiceAppointmentModel> todayAppointments;
  final List<SaleModel> recentSales;

  const DashboardData({
    required this.totalCars,
    required this.totalSpareParts,
    required this.lowStockParts,
    required this.monthlySalesTotal,
    required this.activeLoansCount,
    required this.todayAppointments,
    required this.recentSales,
  });
}

final dashboardProvider = Provider<DashboardData>((ref) {
  final cars = ref.watch(carsProvider);
  final spareParts = ref.watch(sparePartsProvider);
  final lowStock = ref.watch(lowStockPartsProvider);
  final sales = ref.watch(salesProvider);
  final recentSales = ref.watch(recentSalesProvider);
  final activeLoans = ref.watch(activeLoansCountProvider);
  final todayApts = ref.watch(todayAppointmentsProvider);

  final now = DateTime.now();
  final monthlySalesTotal = sales
      .where((sale) => sale.date.year == now.year && sale.date.month == now.month)
      .fold<double>(0, (sum, sale) => sum + sale.amount);

  return DashboardData(
    totalCars: cars.length,
    totalSpareParts: spareParts.length,
    lowStockParts: lowStock,
    monthlySalesTotal: monthlySalesTotal,
    activeLoansCount: activeLoans,
    todayAppointments: todayApts,
    recentSales: recentSales,
  );
});
