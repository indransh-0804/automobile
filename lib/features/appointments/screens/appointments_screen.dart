import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:automobile/core/constants/app_constants.dart';
import 'package:automobile/core/router/route_names.dart';
import 'package:automobile/core/utils/formatters.dart';
import 'package:automobile/providers/appointment_provider.dart';
import 'package:automobile/widgets/display/app_badge.dart';
import 'package:automobile/widgets/display/app_loading_indicator.dart';
import 'package:automobile/widgets/display/app_empty_state.dart';

class AppointmentsScreen extends ConsumerWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appointmentsAsync = ref.watch(appointmentsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Service Appointments')),
      body: appointmentsAsync.when(
        data: (appointments) {
          if (appointments.isEmpty) {
            return const AppEmptyState(
              icon: Icons.calendar_today,
              title: 'No Appointments',
              subtitle: 'Service appointments will appear here.',
            );
          }
          return ListView.builder(
            padding: EdgeInsets.all(kBaseUnit * 2),
            itemCount: appointments.length,
            itemBuilder: (context, index) {
              final appt = appointments[index];
              return Card(
                margin: EdgeInsets.only(bottom: kBaseUnit),
                child: ListTile(
                  title: Text(appt.customerName),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(appt.serviceType),
                      Text(Formatters.formatDateTime(appt.scheduledAt)),
                    ],
                  ),
                  trailing: AppBadge(label: appt.status.name),
                  isThreeLine: true,
                ),
              );
            },
          );
        },
        loading: () => const AppLoadingIndicator(),
        error: (error, _) => Center(child: Text(error.toString())),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.goNamed(RouteNames.appointmentForm),
        child: const Icon(Icons.add),
      ),
    );
  }
}
