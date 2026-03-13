import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class AMIconButton extends StatelessWidget {
  const AMIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.tooltip,
    this.isLoading = false,
    this.color = AppColors.accent,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final String tooltip;
  final bool isLoading;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: IconButton(
        onPressed: isLoading ? null : onPressed,
        icon: isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator.adaptive(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              )
            : Icon(icon, color: color),
      ),
    );
  }
}
