import 'package:flutter/material.dart';
import 'package:automobile/core/utils/extensions.dart';
import 'package:automobile/providers/dashboard_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LowStockAlertBanner extends ConsumerWidget {
  const LowStockAlertBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lowStockParts = ref.watch(dashboardProvider).lowStockParts;

    if (lowStockParts.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: context.paddingMedium,
        vertical: context.paddingSmall,
      ),
      padding: EdgeInsets.all(context.paddingMedium),
      decoration: BoxDecoration(
        color: context.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(context.radiusMedium),
      ),
      child: Row(
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: context.colorScheme.onErrorContainer,
            size: context.iconMedium,
          ),
          SizedBox(width: context.paddingSmall),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Low Stock Alert',
                  style: context.textTheme.titleSmall?.copyWith(
                    color: context.colorScheme.onErrorContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: context.responsive(0.5)),
                Text(
                  '${lowStockParts.length} parts below threshold',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.onErrorContainer,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
