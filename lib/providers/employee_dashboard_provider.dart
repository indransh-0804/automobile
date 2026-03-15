import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:automobile/data/models/dashboard_models.dart';
import 'package:automobile/data/models/task_model.dart';
import 'package:automobile/data/mock/employee_mock_data.dart';

final myPerformanceProvider = Provider<List<KpiMetric>>((_) => EmployeeMockData.myKpiMetrics);
final mySalesChartProvider = Provider<List<MonthlySales>>((_) => EmployeeMockData.myMonthlySales);
final myCustomersProvider = Provider<List<EmployeeCustomer>>((_) => EmployeeMockData.myCustomers);
final myTestDrivesProvider = Provider<List<TestDriveSchedule>>((_) => EmployeeMockData.myTestDrives);
final myRecentSalesProvider = Provider<List<Transaction>>((_) => EmployeeMockData.myRecentSales);

final pendingTasksProvider =
    StateNotifierProvider<PendingTasksNotifier, List<PendingTask>>((_) => PendingTasksNotifier());

class PendingTasksNotifier extends StateNotifier<List<PendingTask>> {
  PendingTasksNotifier() : super(EmployeeMockData.pendingTasks);

  void toggleTask(String id) {
    state = [
      for (final t in state)
        if (t.id == id) t.copyWith(isCompleted: !t.isCompleted) else t
    ];
  }
}