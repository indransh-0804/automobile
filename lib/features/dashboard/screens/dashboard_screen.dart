import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/routing/route_names.dart';
import '../../../widgets/widgets.dart';
import '../providers/dashboard_provider.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  String _formatRevenue(double amount) {
    if (amount >= 10000000) {
      return '₹${(amount / 10000000).toStringAsFixed(2)}Cr';
    } else if (amount >= 100000) {
      return '₹${(amount / 100000).toStringAsFixed(2)}L';
    }
    return '₹${amount.toStringAsFixed(0)}';
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return AppColors.success;
      case 'pending':
        return AppColors.warning;
      case 'cancelled':
        return AppColors.error;
      default:
        return AppColors.onSurfaceMuted;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(dashboardSummaryProvider);
    final recentSalesAsync = ref.watch(recentSalesProvider);
    final lowStockAsync = ref.watch(lowStockAlertsProvider);
    final pendingAsync = ref.watch(pendingActionsProvider);

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final hPad = screenWidth * 0.04;
    final vPad = screenHeight * 0.015;
    final gridSpacing = screenWidth * 0.03;
    final sectionSpacing = screenHeight * 0.025;

    final isLoading = summaryAsync.isLoading ||
        recentSalesAsync.isLoading ||
        lowStockAsync.isLoading ||
        pendingAsync.isLoading;

    final hasError = summaryAsync.hasError ||
        recentSalesAsync.hasError ||
        lowStockAsync.hasError ||
        pendingAsync.hasError;

    final pendingCount = pendingAsync.valueOrNull != null
        ? ((pendingAsync.valueOrNull!['pendingLoans'] ?? 0) +
            (pendingAsync.valueOrNull!['pendingTestDrives'] ?? 0) +
            (pendingAsync.valueOrNull!['pendingServiceAppointments'] ?? 0))
        : 0;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          'AutoMobile',
          style: AppTextStyles.titleLarge.copyWith(color: AppColors.accent),
        ),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              AMIconButton(
                icon: Icons.notifications_outlined,
                onPressed: () {},
                tooltip: 'Notifications',
              ),
              if (pendingCount > 0)
                Positioned(
                  top: 8,
                  right: 8,
                  child: AMBadge(
                    label: '$pendingCount',
                    color: AppColors.error,
                    textColor: AppColors.onPrimary,
                  ),
                ),
            ],
          ),
          AMIconButton(
            icon: Icons.account_circle_outlined,
            onPressed: () {},
            tooltip: 'Account',
          ),
        ],
      ),
      body: SafeArea(
        child: isLoading
            ? const AMLoader()
            : hasError
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: AppColors.error,
                          size: 48,
                        ),
                        SizedBox(height: vPad),
                        Text(
                          summaryAsync.error?.toString() ??
                              recentSalesAsync.error?.toString() ??
                              lowStockAsync.error?.toString() ??
                              pendingAsync.error?.toString() ??
                              'An error occurred',
                          style: AppTextStyles.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: vPad),
                        AMOutlineButton(
                          label: 'Retry',
                          onPressed: () {
                            ref.invalidate(dashboardSummaryProvider);
                            ref.invalidate(recentSalesProvider);
                            ref.invalidate(lowStockAlertsProvider);
                            ref.invalidate(pendingActionsProvider);
                          },
                          isLoading: false,
                        ),
                      ],
                    ),
                  )
                : RefreshIndicator(
                    color: AppColors.accent,
                    onRefresh: () async {
                      ref.invalidate(dashboardSummaryProvider);
                      ref.invalidate(recentSalesProvider);
                      ref.invalidate(lowStockAlertsProvider);
                      ref.invalidate(pendingActionsProvider);
                    },
                    child: CustomScrollView(
                      slivers: [
                        SliverPadding(
                          padding: EdgeInsets.symmetric(
                            horizontal: hPad,
                            vertical: vPad,
                          ),
                          sliver: SliverList(
                            delegate: SliverChildListDelegate([
                              // Section 1 — Greeting Header
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Welcome back,',
                                    style: AppTextStyles.bodySmall.copyWith(
                                      color: AppColors.onSurfaceMuted,
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.005),
                                  Text(
                                    'Owner Dashboard',
                                    style: AppTextStyles.headlineMedium,
                                  ),
                                  SizedBox(height: screenHeight * 0.005),
                                  Text(
                                    DateFormat('EEEE, dd MMMM yyyy')
                                        .format(DateTime.now()),
                                    style: AppTextStyles.labelMedium.copyWith(
                                      color: AppColors.onSurfaceMuted,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: sectionSpacing),

                              // Section 2 — KPI Stat Tiles
                              GridView.count(
                                crossAxisCount: 2,
                                crossAxisSpacing: gridSpacing,
                                mainAxisSpacing: gridSpacing,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                childAspectRatio: 1.4,
                                children: [
                                  AMCard(
                                    child: AMStatTile(
                                      label: 'Total Revenue',
                                      value: _formatRevenue(
                                        summaryAsync.valueOrNull?.totalRevenue ?? 0,
                                      ),
                                      icon: Icons.currency_rupee,
                                      iconColor: AppColors.accent,
                                      trend: summaryAsync
                                          .valueOrNull?.revenueGrowthPercent,
                                    ),
                                  ),
                                  AMCard(
                                    child: AMStatTile(
                                      label: 'Cars Sold',
                                      value: '${summaryAsync.valueOrNull?.totalCarsSold ?? 0}',
                                      icon: Icons.directions_car_outlined,
                                      iconColor: AppColors.primary,
                                    ),
                                  ),
                                  AMCard(
                                    child: AMStatTile(
                                      label: 'Active Loans',
                                      value: '${summaryAsync.valueOrNull?.activeLoans ?? 0}',
                                      icon: Icons.account_balance_outlined,
                                      iconColor: AppColors.warning,
                                    ),
                                  ),
                                  AMCard(
                                    child: AMStatTile(
                                      label: 'Parts Orders',
                                      value: '${summaryAsync.valueOrNull?.totalPartsOrders ?? 0}',
                                      icon: Icons.build_outlined,
                                      iconColor: AppColors.success,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: sectionSpacing),

                              // Section 3 — Pending Actions
                              AMSectionHeader(title: 'Pending Actions'),
                              SizedBox(height: vPad),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    _PendingActionCard(
                                      icon: Icons.approval_outlined,
                                      label: 'Loan Approvals',
                                      count: pendingAsync
                                              .valueOrNull?['pendingLoans'] ??
                                          0,
                                      width: screenWidth * 0.38,
                                      onTap: () =>
                                          context.goNamed('loan'),
                                    ),
                                    SizedBox(width: gridSpacing),
                                    _PendingActionCard(
                                      icon: Icons.drive_eta_outlined,
                                      label: 'Test Drives',
                                      count: pendingAsync
                                              .valueOrNull?['pendingTestDrives'] ??
                                          0,
                                      width: screenWidth * 0.38,
                                      onTap: () =>
                                          context.goNamed('testDrive'),
                                    ),
                                    SizedBox(width: gridSpacing),
                                    _PendingActionCard(
                                      icon: Icons.build_circle_outlined,
                                      label: 'Service Appts',
                                      count: pendingAsync.valueOrNull?[
                                              'pendingServiceAppointments'] ??
                                          0,
                                      width: screenWidth * 0.38,
                                      onTap: () =>
                                          context.goNamed('serviceAppointment'),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: sectionSpacing),

                              // Section 4 — Recent Sales
                              AMSectionHeader(
                                title: 'Recent Sales',
                                actionLabel: 'See All',
                                onAction: () => context.goNamed('reports'),
                              ),
                              SizedBox(height: vPad),
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: recentSalesAsync.valueOrNull?.length ?? 0,
                                separatorBuilder: (_, __) => const Divider(),
                                itemBuilder: (context, index) {
                                  final sale =
                                      recentSalesAsync.valueOrNull![index];
                                  return AMLimitedTile(
                                    leading: CircleAvatar(
                                      backgroundColor: AppColors.surfaceVariant,
                                      child: const Icon(
                                        Icons.person_outline,
                                        color: AppColors.onSurfaceMuted,
                                      ),
                                    ),
                                    title:
                                        '${sale['customerName']} — ${sale['carModel']}',
                                    subtitle: sale['date'] as String,
                                    trailing: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          sale['amount'] as String,
                                          style: AppTextStyles.titleSmall,
                                        ),
                                        const SizedBox(height: 4),
                                        AMBadge(
                                          label: sale['status'] as String,
                                          color: _statusColor(
                                              sale['status'] as String),
                                          textColor: AppColors.onPrimary,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),

                              SizedBox(height: sectionSpacing),

                              // Section 5 — Low Stock Alerts
                              AMSectionHeader(
                                title: 'Low Stock Alerts',
                                actionLabel: 'Manage',
                                onAction: () => context.goNamed('alerts'),
                              ),
                              SizedBox(height: vPad),
                              Column(
                                children: (lowStockAsync.valueOrNull ?? [])
                                    .take(3)
                                    .map((item) {
                                  final currentQty =
                                      item['currentQty'] as int;
                                  final minQty = item['minQty'] as int;
                                  final type = item['type'] as String;
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: vPad),
                                    child: AMCard(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.warning_amber_rounded,
                                            color: currentQty == 0
                                                ? AppColors.error
                                                : AppColors.warning,
                                          ),
                                          SizedBox(width: gridSpacing),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  item['itemName'] as String,
                                                  style: AppTextStyles.bodyMedium
                                                      .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                    height: screenHeight * 0.004),
                                                Text(
                                                  'Stock: $currentQty / $minQty',
                                                  style: AppTextStyles.bodySmall
                                                      .copyWith(
                                                    color: AppColors.onSurfaceMuted,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          AMBadge(
                                            label: type == 'car' ? 'Car' : 'Part',
                                            color: AppColors.primary,
                                            textColor: AppColors.onPrimary,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),

                              SizedBox(height: sectionSpacing),

                              // Section 6 — Quick Actions
                              AMSectionHeader(title: 'Quick Actions'),
                              SizedBox(height: vPad),
                              Wrap(
                                spacing: gridSpacing,
                                runSpacing: gridSpacing,
                                children: [
                                  AMOutlineButton(
                                    label: 'Add Car',
                                    onPressed: () =>
                                        context.goNamed('inventory'),
                                    prefixIcon: Icons.add_circle_outline,
                                    width: screenWidth * 0.43,
                                    isLoading: false,
                                  ),
                                  AMOutlineButton(
                                    label: 'New Purchase',
                                    onPressed: () =>
                                        context.goNamed('purchase'),
                                    prefixIcon: Icons.receipt_long_outlined,
                                    width: screenWidth * 0.43,
                                    isLoading: false,
                                  ),
                                  AMOutlineButton(
                                    label: 'Book Test Drive',
                                    onPressed: () =>
                                        context.goNamed('testDrive'),
                                    prefixIcon: Icons.directions_car_outlined,
                                    width: screenWidth * 0.43,
                                    isLoading: false,
                                  ),
                                  AMOutlineButton(
                                    label: 'Service Appointment',
                                    onPressed: () =>
                                        context.goNamed('serviceAppointment'),
                                    prefixIcon: Icons.build_outlined,
                                    width: screenWidth * 0.43,
                                    isLoading: false,
                                  ),
                                  AMOutlineButton(
                                    label: 'Generate Bill',
                                    onPressed: () =>
                                        context.goNamed('billing'),
                                    prefixIcon: Icons.picture_as_pdf_outlined,
                                    width: screenWidth * 0.43,
                                    isLoading: false,
                                  ),
                                ],
                              ),

                              SizedBox(height: sectionSpacing),
                            ]),
                          ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}

class _PendingActionCard extends StatelessWidget {
  const _PendingActionCard({
    required this.icon,
    required this.label,
    required this.count,
    required this.width,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final int count;
  final double width;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: AMCard(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppColors.accent),
            SizedBox(height: MediaQuery.of(context).size.height * 0.008),
            Text(
              '$count',
              style: AppTextStyles.headlineSmall,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.004),
            Text(
              label,
              style: AppTextStyles.labelSmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
