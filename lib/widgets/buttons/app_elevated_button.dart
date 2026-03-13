import 'package:flutter/material.dart';

class AppElevatedButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? prefixIcon;

  const AppElevatedButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.of(context).textScaler.scale(1.0);
    final indicatorSize = 20.0 * textScale;

    return FilledButton(
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? SizedBox(
              width: indicatorSize,
              height: indicatorSize,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (prefixIcon != null) ...[
                  Icon(prefixIcon),
                  const SizedBox(width: 8),
                ],
                Text(label),
              ],
            ),
    );
  }
}
