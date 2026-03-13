import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class AMStatTile extends StatelessWidget {
  const AMStatTile({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.iconColor,
    this.trend,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color iconColor;
  final double? trend;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: iconColor, size: 24),
        const SizedBox(height: 8),
        Text(value, style: AppTextStyles.headlineMedium),
        const SizedBox(height: 4),
        Text(label, style: AppTextStyles.labelMedium),
        if (trend != null) ...[
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(
                trend! >= 0 ? Icons.arrow_upward : Icons.arrow_downward,
                color: trend! >= 0 ? AppColors.success : AppColors.error,
                size: 14,
              ),
              const SizedBox(width: 4),
              Text(
                trend! >= 0
                    ? '+${trend!.toStringAsFixed(1)}%'
                    : '${trend!.toStringAsFixed(1)}%',
                style: AppTextStyles.labelSmall.copyWith(
                  color: trend! >= 0 ? AppColors.success : AppColors.error,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
