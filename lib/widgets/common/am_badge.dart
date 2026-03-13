import 'package:flutter/material.dart';
import '../../core/theme/app_text_styles.dart';

class AMBadge extends StatelessWidget {
  const AMBadge({
    super.key,
    required this.label,
    required this.color,
    required this.textColor,
  });

  final String label;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(50)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Text(
        label,
        style: AppTextStyles.labelSmall.copyWith(color: textColor),
      ),
    );
  }
}
