import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:automobile/core/utils/formatters.dart';
import 'package:automobile/providers/dashboard_provider.dart';
import 'package:automobile/widgets/display/app_stat_card.dart';

class DashboardSummaryRow extends ConsumerWidget {
  const DashboardSummaryRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalCars = ref.watch(totalCarsProvider);
    final totalSpareParts = ref.watch(totalSparePartsProvider);
    final monthlySales = ref.watch(monthlySalesProvider);
    final activeLoans = ref.watch(activeLoansCountProvider);
    final todayAppointments = ref.watch(todayAppointmentsCountProvider);
    final cardWidth = MediaQuery.of(context).size.width / 2.5;

    return SizedBox(
      height: cardWidth,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          SizedBox(
            width: cardWidth,
            child: AppStatCard(
              title: 'Total Cars',
              value: totalCars.toString(),
              icon: Icons.directions_car,
            ),
          ),
          SizedBox(
            width: cardWidth,
            child: AppStatCard(
              title: 'Spare Parts',
              value: totalSpareParts.toString(),
              icon: Icons.settings,
            ),
          ),
          SizedBox(
            width: cardWidth,
            child: AppStatCard(
              title: 'Monthly Sales',
              value: Formatters.formatCurrency(monthlySales),
              icon: Icons.trending_up,
            ),
          ),
          SizedBox(
            width: cardWidth,
            child: AppStatCard(
              title: 'Active Loans',
              value: activeLoans.toString(),
              icon: Icons.account_balance,
            ),
          ),
          SizedBox(
            width: cardWidth,
            child: AppStatCard(
              title: "Today's Appointments",
              value: todayAppointments.toString(),
              icon: Icons.calendar_today,
            ),
          ),
        ],
      ),
    );
  }
}
