import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:automobile/core/router/route_names.dart';
import 'package:automobile/core/constants/app_constants.dart';
import 'package:automobile/providers/dashboard_provider.dart';

class LowStockAlertBanner extends ConsumerWidget {
  const LowStockAlertBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lowStockParts = ref.watch(dashboardLowStockPartsProvider);

    if (lowStockParts.isEmpty) {
      return const SizedBox.shrink();
    }

    final scheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => context.goNamed(RouteNames.inventory),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(kBaseUnit * 2),
        decoration: BoxDecoration(
          color: scheme.errorContainer,
          borderRadius: BorderRadius.circular(kBaseUnit * 1.5),
        ),
        child: Row(
          children: [
            Icon(
              Icons.warning_amber_rounded,
              color: scheme.onErrorContainer,
              size: kBaseUnit * 3,
            ),
            SizedBox(width: kBaseUnit * 1.5),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Low Stock Alert',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: scheme.onErrorContainer,
                        ),
                  ),
                  SizedBox(height: kBaseUnit * 0.5),
                  Text(
                    '${lowStockParts.length} spare part(s) running low on stock',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: scheme.onErrorContainer,
                        ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: scheme.onErrorContainer,
            ),
          ],
        ),
      ),
    );
  }
}
