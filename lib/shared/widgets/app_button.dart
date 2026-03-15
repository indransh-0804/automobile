// lib/shared/widgets/app_button.dart
import 'package:flutter/material.dart';

import '../../core/theme/app_dimensions.dart';

enum AppButtonVariant { primary, secondary, ghost }

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final bool isFullWidth;
  final IconData? prefixIcon;

  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.isFullWidth = false,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final child = _buildButton(context);

    if (isFullWidth) {
      return SizedBox(
        width: double.infinity,
        height: AppDimensions.buttonHeight,
        child: child,
      );
    }

    return SizedBox(
      height: AppDimensions.buttonHeight,
      child: child,
    );
  }

  Widget _buildButton(BuildContext context) {
    final buttonChild = prefixIcon != null
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(prefixIcon, size: AppDimensions.iconSizeSm),
              SizedBox(width: AppDimensions.spacingSm),
              Text(label),
            ],
          )
        : Text(label);

    switch (variant) {
      case AppButtonVariant.primary:
        return FilledButton(
          onPressed: onPressed,
          child: buttonChild,
        );
      case AppButtonVariant.secondary:
        return OutlinedButton(
          onPressed: onPressed,
          child: buttonChild,
        );
      case AppButtonVariant.ghost:
        return TextButton(
          onPressed: onPressed,
          child: buttonChild,
        );
    }
  }
}
