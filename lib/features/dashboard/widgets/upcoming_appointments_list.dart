import 'package:flutter/material.dart';
import 'package:automobile/core/utils/extensions.dart';
import 'package:automobile/models/service_appointment_model.dart';
import 'package:automobile/providers/dashboard_provider.dart';
import 'package:automobile/widgets/display/app_section_header.dart';
import 'package:automobile/widgets/display/app_empty_state.dart';
import 'package:automobile/widgets/display/app_badge.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpcomingAppointmentsList extends ConsumerWidget {
  const UpcomingAppointmentsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todayAppointments = ref.watch(dashboardProvider).todayAppointments;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppSectionHeader(title: "Today's Appointments"),
          if (todayAppointments.isEmpty)
            const AppEmptyState(
              icon: Icons.calendar_today,
              title: 'No Appointments Today',
              subtitle: 'Scheduled appointments will appear here.',
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: todayAppointments.length,
              itemBuilder: (context, index) {
                final appointment = todayAppointments[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(appointment.customerName),
                  subtitle: Text(appointment.serviceType),
                  trailing: AppBadge(
                    label: _statusLabel(appointment.status),
                    color: _statusColor(context, appointment.status),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  String _statusLabel(AppointmentStatus status) {
    switch (status) {
      case AppointmentStatus.pending:
        return 'Pending';
      case AppointmentStatus.inProgress:
        return 'In Progress';
      case AppointmentStatus.done:
        return 'Done';
    }
  }

  Color _statusColor(BuildContext context, AppointmentStatus status) {
    final scheme = context.colorScheme;
    switch (status) {
      case AppointmentStatus.pending:
        return scheme.tertiary;
      case AppointmentStatus.inProgress:
        return scheme.primary;
      case AppointmentStatus.done:
        return scheme.secondary;
    }
  }
}
