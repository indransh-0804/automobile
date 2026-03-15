// lib/shared/widgets/app_data_chip.dart
import 'package:flutter/material.dart';

import '../../core/theme/app_dimensions.dart';

class AppDataChip extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const AppDataChip({
    super.key,
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacingSm,
        vertical: AppDimensions.spacingXs,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              fontSize: AppDimensions.fontSizeXs,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: AppDimensions.spacingXxs),
          Text(
            value,
            style: theme.textTheme.labelMedium?.copyWith(
              fontSize: AppDimensions.fontSizeSm,
              fontWeight: FontWeight.w700,
              color: valueColor ?? theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
