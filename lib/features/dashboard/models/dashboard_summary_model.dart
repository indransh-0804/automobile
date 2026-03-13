class DashboardSummaryModel {
  const DashboardSummaryModel({
    required this.totalRevenue,
    required this.totalCarsSold,
    required this.totalPartsOrders,
    required this.activeLoans,
    required this.monthlyRevenueList,
    required this.topSellingModel,
    required this.revenueGrowthPercent,
  });

  final double totalRevenue;
  final int totalCarsSold;
  final int totalPartsOrders;
  final int activeLoans;
  final List<double> monthlyRevenueList;
  final String topSellingModel;
  final double revenueGrowthPercent;
}
