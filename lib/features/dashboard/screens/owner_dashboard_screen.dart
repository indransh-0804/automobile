import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:automobile/core/router/route_names.dart';
import 'package:automobile/core/constants/app_constants.dart';
import 'package:automobile/core/utils/formatters.dart';
import 'package:automobile/providers/dashboard_provider.dart';
import 'package:automobile/providers/appointment_provider.dart';
import 'package:automobile/features/dashboard/widgets/low_stock_alert_banner.dart';
import 'package:automobile/features/dashboard/widgets/dashboard_summary_row.dart';
import 'package:automobile/features/dashboard/widgets/quick_action_grid.dart';
import 'package:automobile/features/dashboard/widgets/recent_sales_list.dart';
import 'package:automobile/widgets/display/app_section_header.dart';
import 'package:automobile/widgets/display/app_empty_state.dart';

class OwnerDashboardScreen extends ConsumerWidget {
  const OwnerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todayAppointments = ref.watch(todayAppointmentsProvider);
    final padding = kBaseUnit * 2;

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          title: Text(
            'AutoMobile',
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.all(padding),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              const LowStockAlertBanner(),
              SizedBox(height: kBaseUnit * 2),
              const DashboardSummaryRow(),
              SizedBox(height: kBaseUnit * 3),
              const QuickActionGrid(),
              SizedBox(height: kBaseUnit * 3),
              const RecentSalesList(),
              SizedBox(height: kBaseUnit * 3),
              AppSectionHeader(
                title: 'Upcoming Appointments',
                trailingLabel: 'View All',
                onTrailingTap: () =>
                    context.goNamed(RouteNames.appointments),
              ),
              SizedBox(height: kBaseUnit),
              if (todayAppointments.isEmpty)
                const AppEmptyState(
                  icon: Icons.calendar_today,
                  title: 'No Appointments Today',
                  subtitle: 'There are no service appointments scheduled for today.',
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: todayAppointments.length,
                  itemBuilder: (context, index) {
                    final appointment = todayAppointments[index];
                    return ListTile(
                      title: Text(appointment.customerName),
                      subtitle: Text(appointment.serviceType),
                      trailing: Text(
                        Formatters.formatDateTime(appointment.scheduledAt),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    );
                  },
                ),
            ]),
          ),
        ),
      ],
    );
  }
}
