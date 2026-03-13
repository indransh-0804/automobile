import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:automobile/core/utils/extensions.dart';
import 'package:automobile/features/dashboard/widgets/low_stock_alert_banner.dart';
import 'package:automobile/features/dashboard/widgets/dashboard_summary_row.dart';
import 'package:automobile/features/dashboard/widgets/quick_action_grid.dart';
import 'package:automobile/features/dashboard/widgets/recent_sales_list.dart';
import 'package:automobile/features/dashboard/widgets/upcoming_appointments_list.dart';

class OwnerDashboardScreen extends ConsumerWidget {
  const OwnerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            title: Text(
              'AutoMobile',
              style: context.textTheme.displaySmall,
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: context.paddingMedium),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const LowStockAlertBanner(),
                SizedBox(height: context.paddingMedium),
                const DashboardSummaryRow(),
                SizedBox(height: context.paddingMedium),
                const QuickActionGrid(),
                SizedBox(height: context.paddingMedium),
                const RecentSalesList(),
                SizedBox(height: context.paddingMedium),
                const UpcomingAppointmentsList(),
                SizedBox(height: context.paddingLarge),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
