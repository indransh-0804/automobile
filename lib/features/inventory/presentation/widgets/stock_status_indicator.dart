// lib/features/inventory/presentation/widgets/stock_status_indicator.dart
import 'package:flutter/material.dart';

import '../../../../core/theme/app_dimensions.dart';
import '../../domain/enums/stock_status.dart';

class StockStatusIndicator extends StatelessWidget {
  final StockStatus status;

  const StockStatusIndicator({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final statusColor = status.colorToken(colorScheme);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: AppDimensions.spacingSm,
          height: AppDimensions.spacingSm,
          decoration: BoxDecoration(
            color: statusColor,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: AppDimensions.spacingXs),
        Text(
          status.label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: statusColor,
                fontSize: AppDimensions.fontSizeXs,
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}
