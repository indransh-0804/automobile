import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/dashboard_summary_model.dart';

// TODO: Replace Future.delayed stub with a Firestore call, e.g.:
// final doc = await FirebaseFirestore.instance.collection('dashboard').doc('summary').get();
// return DashboardSummaryModel.fromJson(doc.data()!);
final dashboardSummaryProvider = FutureProvider<DashboardSummaryModel>((ref) async {
  await Future<void>.delayed(const Duration(seconds: 1));
  return const DashboardSummaryModel(
    totalRevenue: 12450000,
    totalCarsSold: 48,
    totalPartsOrders: 134,
    activeLoans: 22,
    monthlyRevenueList: [
      980000, 1050000, 1200000, 1100000, 1350000, 1420000,
      1300000, 1250000, 1180000, 1400000, 1520000, 1700000,
    ],
    topSellingModel: 'Toyota Fortuner',
    revenueGrowthPercent: 12.4,
  );
});

// TODO: Replace stub with Firestore query for recent sales collection.
final recentSalesProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  await Future<void>.delayed(const Duration(seconds: 1));
  return [
    {
      'customerName': 'Arjun Sharma',
      'carModel': 'Honda City',
      'amount': '₹12,50,000',
      'date': '2024-03-10',
      'status': 'Completed',
    },
    {
      'customerName': 'Priya Mehta',
      'carModel': 'Hyundai Creta',
      'amount': '₹15,80,000',
      'date': '2024-03-09',
      'status': 'Pending',
    },
    {
      'customerName': 'Rahul Gupta',
      'carModel': 'Toyota Fortuner',
      'amount': '₹38,00,000',
      'date': '2024-03-08',
      'status': 'Completed',
    },
    {
      'customerName': 'Sneha Patel',
      'carModel': 'Maruti Swift',
      'amount': '₹7,20,000',
      'date': '2024-03-07',
      'status': 'Cancelled',
    },
    {
      'customerName': 'Vikram Singh',
      'carModel': 'Kia Seltos',
      'amount': '₹18,90,000',
      'date': '2024-03-06',
      'status': 'Completed',
    },
  ];
});

// TODO: Replace stub with Firestore query for inventory items below minimum stock.
final lowStockAlertsProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  await Future<void>.delayed(const Duration(seconds: 1));
  return [
    {
      'itemName': 'Brake Pads (Set)',
      'currentQty': 3,
      'minQty': 10,
      'type': 'part',
    },
    {
      'itemName': 'Maruti Swift (White)',
      'currentQty': 0,
      'minQty': 2,
      'type': 'car',
    },
    {
      'itemName': 'Engine Oil Filter',
      'currentQty': 5,
      'minQty': 15,
      'type': 'part',
    },
  ];
});

// TODO: Replace stub with Firestore aggregation queries for pending counts.
final pendingActionsProvider = FutureProvider<Map<String, int>>((ref) async {
  await Future<void>.delayed(const Duration(seconds: 1));
  return {
    'pendingLoans': 7,
    'pendingTestDrives': 4,
    'pendingServiceAppointments': 11,
  };
});
