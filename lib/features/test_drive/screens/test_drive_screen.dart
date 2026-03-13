import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:automobile/core/constants/app_constants.dart';
import 'package:automobile/core/router/route_names.dart';
import 'package:automobile/core/utils/formatters.dart';
import 'package:automobile/providers/test_drive_provider.dart';
import 'package:automobile/widgets/display/app_badge.dart';
import 'package:automobile/widgets/display/app_loading_indicator.dart';
import 'package:automobile/widgets/display/app_empty_state.dart';

class TestDriveScreen extends ConsumerWidget {
  const TestDriveScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final testDrivesAsync = ref.watch(testDrivesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Test Drives')),
      body: testDrivesAsync.when(
        data: (testDrives) {
          if (testDrives.isEmpty) {
            return const AppEmptyState(
              icon: Icons.car_rental,
              title: 'No Test Drives',
              subtitle: 'Test drive records will appear here.',
            );
          }
          return ListView.builder(
            padding: EdgeInsets.all(kBaseUnit * 2),
            itemCount: testDrives.length,
            itemBuilder: (context, index) {
              final td = testDrives[index];
              return Card(
                margin: EdgeInsets.only(bottom: kBaseUnit),
                child: ListTile(
                  title: Text(td.customerName),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(td.carName),
                      Text(Formatters.formatDateTime(td.scheduledAt)),
                    ],
                  ),
                  trailing: AppBadge(label: td.status.name),
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
        onPressed: () => context.goNamed(RouteNames.testDriveForm),
        child: const Icon(Icons.add),
      ),
    );
  }
}
