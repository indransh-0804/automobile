// lib/shared/widgets/app_badge.dart
import 'package:flutter/material.dart';

import '../../core/theme/app_dimensions.dart';

class AppBadge extends StatelessWidget {
  final String label;
  final Color? color;

  const AppBadge({
    super.key,
    required this.label,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final badgeColor = color ?? theme.colorScheme.surfaceContainerHighest;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacingSm,
        vertical: AppDimensions.spacingXs,
      ),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelSmall?.copyWith(
          fontSize: AppDimensions.fontSizeXs,
        ),
      ),
    );
  }
}
