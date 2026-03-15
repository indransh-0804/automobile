import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:automobile/data/models/dashboard_models.dart';
import 'package:automobile/data/mock/mock_data.dart';

final kpiMetricsProvider = Provider<List<KpiMetric>>((_) => MockData.kpiMetrics);
final inventoryStatusProvider = Provider<InventoryStatus>((_) => MockData.inventoryStatus);
final recentTransactionsProvider = Provider<List<Transaction>>((_) => MockData.recentTransactions);
final loanOverviewProvider = Provider<LoanOverview>((_) => MockData.loanOverview);
final upcomingTestDrivesProvider = Provider<List<TestDriveSchedule>>((_) => MockData.upcomingTestDrives);
final monthlySalesProvider = Provider<List<MonthlySales>>((_) => MockData.monthlySales);
final bottomNavIndexProvider = StateProvider<int>((_) => 0);