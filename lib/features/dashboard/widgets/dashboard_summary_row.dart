import 'package:flutter/material.dart';
import 'package:automobile/core/utils/extensions.dart';
import 'package:automobile/core/utils/formatters.dart';
import 'package:automobile/providers/dashboard_provider.dart';
import 'package:automobile/widgets/display/app_stat_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardSummaryRow extends ConsumerWidget {
  const DashboardSummaryRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboard = ref.watch(dashboardProvider);
    final cardWidth = context.screenWidth / 2.5;

    return SizedBox(
      height: cardWidth * 0.75,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: context.paddingMedium),
        children: [
          SizedBox(
            width: cardWidth,
            child: AppStatCard(
              title: 'Total Cars',
              value: '${dashboard.totalCars}',
              icon: Icons.directions_car,
            ),
          ),
          SizedBox(width: context.paddingSmall),
          SizedBox(
            width: cardWidth,
            child: AppStatCard(
              title: 'Spare Parts',
              value: '${dashboard.totalSpareParts}',
              icon: Icons.settings,
            ),
          ),
          SizedBox(width: context.paddingSmall),
          SizedBox(
            width: cardWidth,
            child: AppStatCard(
              title: 'Monthly Sales',
              value: Formatters.compactCurrency(dashboard.monthlySalesTotal),
              icon: Icons.trending_up,
            ),
          ),
          SizedBox(width: context.paddingSmall),
          SizedBox(
            width: cardWidth,
            child: AppStatCard(
              title: 'Active Loans',
              value: '${dashboard.activeLoansCount}',
              icon: Icons.account_balance,
            ),
          ),
          SizedBox(width: context.paddingSmall),
          SizedBox(
            width: cardWidth,
            child: AppStatCard(
              title: "Today's Appointments",
              value: '${dashboard.todayAppointments.length}',
              icon: Icons.calendar_today,
            ),
          ),
        ],
      ),
    );
  }
}
