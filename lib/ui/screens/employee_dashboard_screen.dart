import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animate_do/animate_do.dart';
import 'package:intl/intl.dart';

import 'package:automobile/core/core.dart';
import 'package:automobile/core/constants/app_colors.dart';
import 'package:automobile/data/mock/employee_mock_data.dart';
import 'package:automobile/providers/dashboard_provider.dart';
import 'package:automobile/providers/employee_dashboard_provider.dart';
import 'package:automobile/ui/widgets/kpi_card.dart';
import 'package:automobile/ui/widgets/sales_chart.dart';
import 'package:automobile/ui/widgets/glass_card.dart';
import 'package:automobile/ui/widgets/section_title.dart';
import 'package:automobile/ui/widgets/test_drive_card.dart';
import 'package:automobile/ui/widgets/transaction_item.dart';
import 'package:automobile/ui/widgets/quick_action_button.dart';
import 'package:automobile/ui/widgets/shift_tracker_card.dart';
import 'package:automobile/ui/widgets/pending_tasks_card.dart';
import 'package:automobile/ui/widgets/customer_tile.dart';

class EmployeeDashboardScreen extends ConsumerWidget {
  const EmployeeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final kpis = ref.watch(myPerformanceProvider);
    final sales = ref.watch(mySalesChartProvider);
    final customers = ref.watch(myCustomersProvider);
    final testDrives = ref.watch(myTestDrivesProvider);
    final recentSales = ref.watch(myRecentSalesProvider);
    final navIndex = ref.watch(bottomNavIndexProvider);

    final gradients = [
      AppColors.revenueGradient,
      AppColors.salesGradient,
      AppColors.testDriveGradient,
      AppColors.loansGradient,
    ];

    final salesRemaining = EmployeeMockData.monthlyTarget - EmployeeMockData.currentSalesCount;

    return Scaffold(
      appBar: DashboardAppBar(
        greeting: 'Hey, ${EmployeeMockData.employeeName.split(' ')[0]}',
        subtitle: '${EmployeeMockData.employeeTitle} · ${DateFormat('d MMM yyyy').format(DateTime.now())}',
        initials: EmployeeMockData.employeeInitials,
        notificationCount: EmployeeMockData.notificationCount,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: cs.surface,
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.w(8),
              vertical: SizeConfig.h(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Shift Tracker ──
                FadeInDown(
                  duration: const Duration(milliseconds: 600),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: SizeConfig.w(8)),
                    child: const ShiftTrackerCard(),
                  ),
                ),

                SizedBox(height: SizeConfig.h(24)),

                // ── KPI Cards ──
                FadeInDown(
                  duration: const Duration(milliseconds: 600),
                  delay: const Duration(milliseconds: 100),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: SizeConfig.w(8)),
                    child: SectionTitle(title: 'My Performance', trailing: 'This Month'),
                  ),
                ),
                FadeInLeft(
                  duration: const Duration(milliseconds: 700),
                  delay: const Duration(milliseconds: 150),
                  child: SizedBox(
                    height: SizeConfig.h(160),
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: SizeConfig.w(8)),
                      itemCount: kpis.length,
                      separatorBuilder: (_, __) => SizedBox(width: SizeConfig.w(12)),
                      itemBuilder: (context, index) =>
                          KpiCard(metric: kpis[index], gradient: gradients[index]),
                    ),
                  ),
                ),

                SizedBox(height: SizeConfig.h(24)),

                // ── Sales Chart ──
                FadeInUp(
                  duration: const Duration(milliseconds: 700),
                  delay: const Duration(milliseconds: 200),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: SizeConfig.w(8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SectionTitle(title: 'My Sales This Month', trailing: 'Weekly'),
                        GlassCard(
                          child: Column(children: [
                            Row(children: [
                              Container(
                                width: SizeConfig.w(8), height: SizeConfig.w(8),
                                decoration: BoxDecoration(color: cs.primary, shape: BoxShape.circle),
                              ),
                              SizedBox(width: SizeConfig.w(8)),
                              Text('Cars Sold', style: tt.labelSmall?.copyWith(color: cs.onSurfaceVariant)),
                            ]),
                            SizedBox(height: SizeConfig.h(16)),
                            SalesChart(data: sales),
                            SizedBox(height: SizeConfig.h(12)),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.w(12),
                                vertical: SizeConfig.h(8),
                              ),
                              decoration: BoxDecoration(
                                color: cs.primary.withValues(alpha: 0.08),
                                borderRadius: BorderRadius.circular(SizeConfig.w(8)),
                                border: Border.all(color: cs.primary.withValues(alpha: 0.15)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.emoji_events_rounded, color: cs.primary, size: SizeConfig.w(16)),
                                  SizedBox(width: SizeConfig.w(8)),
                                  RichText(
                                    text: TextSpan(
                                      style: tt.labelSmall?.copyWith(color: cs.onSurfaceVariant),
                                      children: [
                                        TextSpan(
                                          text: '$salesRemaining sales ',
                                          style: TextStyle(color: cs.primary, fontWeight: FontWeight.w800),
                                        ),
                                        const TextSpan(text: 'away from your monthly target!'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: SizeConfig.h(24)),

                // ── Pending Tasks ──
                FadeInUp(
                  duration: const Duration(milliseconds: 700),
                  delay: const Duration(milliseconds: 300),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: SizeConfig.w(8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SectionTitle(title: "Today's Tasks"),
                        const PendingTasksCard(),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: SizeConfig.h(24)),

                // ── My Customers ──
                FadeInUp(
                  duration: const Duration(milliseconds: 700),
                  delay: const Duration(milliseconds: 400),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: SizeConfig.w(8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SectionTitle(title: 'My Assigned Customers', trailing: 'View All'),
                        ...customers.map((c) => CustomerTile(customer: c, onTap: () {})),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: SizeConfig.h(24)),

                // ── Test Drives ──
                FadeInUp(
                  duration: const Duration(milliseconds: 700),
                  delay: const Duration(milliseconds: 500),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: SizeConfig.w(8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SectionTitle(title: 'My Upcoming Test Drives', trailing: 'Next 48h'),
                        ...testDrives.asMap().entries.map(
                          (e) => TestDriveCard(schedule: e.value, isLast: e.key == testDrives.length - 1),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: SizeConfig.h(24)),

                // ── Recent Sales ──
                FadeInUp(
                  duration: const Duration(milliseconds: 700),
                  delay: const Duration(milliseconds: 600),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: SizeConfig.w(8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SectionTitle(title: 'My Recent Sales', trailing: 'View All'),
                        ...recentSales.map((t) => TransactionItem(transaction: t)),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: SizeConfig.h(24)),

                // ── Quick Actions ──
                FadeInUp(
                  duration: const Duration(milliseconds: 700),
                  delay: const Duration(milliseconds: 700),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: SizeConfig.w(8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SectionTitle(title: 'Quick Actions'),
                        Row(children: [
                          QuickActionButton(icon: Icons.point_of_sale_rounded, label: 'New Sale', onTap: () {}),
                          SizedBox(width: SizeConfig.w(8)),
                          QuickActionButton(icon: Icons.calendar_month_rounded, label: 'Test Drive', onTap: () {}),
                        ]),
                        SizedBox(height: SizeConfig.h(8)),
                        Row(children: [
                          QuickActionButton(icon: Icons.person_add_alt_1_rounded, label: 'Add Customer', onTap: () {}),
                          SizedBox(width: SizeConfig.w(8)),
                          QuickActionButton(icon: Icons.inventory_2_rounded, label: 'View Inventory', onTap: () {}),
                        ]),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: SizeConfig.h(24)),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: DashboardBottomNav(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard_rounded), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.people_rounded), label: 'My Customers'),
          BottomNavigationBarItem(icon: Icon(Icons.inventory_2_rounded), label: 'Inventory'),
          BottomNavigationBarItem(icon: Icon(Icons.speed_rounded), label: 'Test Drives'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz_rounded), label: 'More'),
        ],
      ),
    );
  }
}