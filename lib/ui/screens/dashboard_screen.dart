import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animate_do/animate_do.dart';
import 'package:intl/intl.dart';

import 'package:automobile/core/core.dart';
import 'package:automobile/core/constants/app_colors.dart';
import 'package:automobile/data/mock/mock_data.dart';
import 'package:automobile/providers/dashboard_provider.dart';
import 'package:automobile/ui/widgets/glass_card.dart';
import 'package:automobile/ui/widgets/kpi_card.dart';
import 'package:automobile/ui/widgets/sales_chart.dart';
import 'package:automobile/ui/widgets/inventory_tile.dart';
import 'package:automobile/ui/widgets/transaction_item.dart';
import 'package:automobile/ui/widgets/test_drive_card.dart';
import 'package:automobile/ui/widgets/loan_overview_bar.dart';
import 'package:automobile/ui/widgets/section_title.dart';
import 'package:automobile/ui/widgets/quick_action_button.dart';

class OwnerDashboardScreen extends ConsumerWidget {
  const OwnerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final kpis = ref.watch(kpiMetricsProvider);
    final inventory = ref.watch(inventoryStatusProvider);
    final transactions = ref.watch(recentTransactionsProvider);
    final loans = ref.watch(loanOverviewProvider);
    final testDrives = ref.watch(upcomingTestDrivesProvider);
    final sales = ref.watch(monthlySalesProvider);
    final navIndex = ref.watch(bottomNavIndexProvider);

    final gradients = [
      AppColors.revenueGradient,
      AppColors.salesGradient,
      AppColors.loansGradient,
      AppColors.testDriveGradient,
    ];

    return Scaffold(
      appBar: DashboardAppBar(
        greeting: 'Good Morning, ${MockData.ownerName.split(' ')[0]}',
        subtitle: DateFormat('EEEE, d MMMM yyyy').format(DateTime.now()),
        initials: MockData.ownerInitials,
        notificationCount: MockData.notificationCount,
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
                // ── KPI Cards ──
                FadeInDown(
                  duration: const Duration(milliseconds: 600),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: SizeConfig.w(8)),
                    child: SectionTitle(title: 'Performance Overview', trailing: 'This Month'),
                  ),
                ),
                FadeInLeft(
                  duration: const Duration(milliseconds: 700),
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
                  delay: const Duration(milliseconds: 100),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: SizeConfig.w(8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SectionTitle(title: 'Sales Overview', trailing: '2026'),
                        GlassCard(
                          child: Column(children: [
                            Row(children: [
                              Container(
                                width: SizeConfig.w(8),
                                height: SizeConfig.w(8),
                                decoration: BoxDecoration(color: cs.primary, shape: BoxShape.circle),
                              ),
                              SizedBox(width: SizeConfig.w(8)),
                              Text('Cars Sold', style: tt.labelSmall?.copyWith(color: cs.onSurfaceVariant)),
                            ]),
                            SizedBox(height: SizeConfig.h(16)),
                            SalesChart(data: sales),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: SizeConfig.h(24)),

                // ── Inventory Status ──
                FadeInUp(
                  duration: const Duration(milliseconds: 700),
                  delay: const Duration(milliseconds: 200),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: SizeConfig.w(8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SectionTitle(title: 'Inventory Status'),
                        Row(children: [
                          InventoryTile(label: 'Available', count: inventory.available, total: inventory.total, color: AppColors.success, icon: Icons.check_circle_outline_rounded),
                          SizedBox(width: SizeConfig.w(8)),
                          InventoryTile(label: 'Reserved', count: inventory.reserved, total: inventory.total, color: cs.primary, icon: Icons.bookmark_outline_rounded),
                          SizedBox(width: SizeConfig.w(8)),
                          InventoryTile(label: 'Sold', count: inventory.sold, total: inventory.total, color: AppColors.info, icon: Icons.sell_outlined),
                        ]),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: SizeConfig.h(24)),

                // ── Recent Transactions ──
                FadeInUp(
                  duration: const Duration(milliseconds: 700),
                  delay: const Duration(milliseconds: 300),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: SizeConfig.w(8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SectionTitle(title: 'Recent Transactions', trailing: 'View All'),
                        ...transactions.map((t) => TransactionItem(transaction: t)),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: SizeConfig.h(24)),

                // ── Loan Overview ──
                FadeInUp(
                  duration: const Duration(milliseconds: 700),
                  delay: const Duration(milliseconds: 400),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: SizeConfig.w(8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SectionTitle(title: 'Loan Repayment Overview'),
                        LoanOverviewBar(data: loans),
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
                        const SectionTitle(title: 'Upcoming Test Drives'),
                        ...testDrives.asMap().entries.map(
                          (e) => TestDriveCard(schedule: e.value, isLast: e.key == testDrives.length - 1),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: SizeConfig.h(24)),

                // ── Quick Actions ──
                FadeInUp(
                  duration: const Duration(milliseconds: 700),
                  delay: const Duration(milliseconds: 600),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: SizeConfig.w(8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SectionTitle(title: 'Quick Actions'),
                        Row(children: [
                          QuickActionButton(icon: Icons.point_of_sale_rounded, label: 'New Sale', onTap: () {}),
                          SizedBox(width: SizeConfig.w(8)),
                          QuickActionButton(icon: Icons.add_circle_outline_rounded, label: 'Add Car', onTap: () {}),
                        ]),
                        SizedBox(height: SizeConfig.h(8)),
                        Row(children: [
                          QuickActionButton(icon: Icons.calendar_month_rounded, label: 'Test Drive', onTap: () {}),
                          SizedBox(width: SizeConfig.w(8)),
                          QuickActionButton(icon: Icons.person_add_alt_1_rounded, label: 'Add Customer', onTap: () {}),
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
          BottomNavigationBarItem(icon: Icon(Icons.inventory_2_rounded), label: 'Inventory'),
          BottomNavigationBarItem(icon: Icon(Icons.people_rounded), label: 'Customers'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_rounded), label: 'Loans'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz_rounded), label: 'More'),
        ],
      ),
    );
  }
}