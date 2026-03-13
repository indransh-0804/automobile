import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final bool isLoading;

  const AppIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.tooltip,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.of(context).textScaler.scale(1.0);
    final indicatorSize = 18.0 * textScale;

    return IconButton(
      onPressed: isLoading ? null : onPressed,
      tooltip: tooltip,
      icon: isLoading
          ? SizedBox(
              width: indicatorSize,
              height: indicatorSize,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Theme.of(context).colorScheme.primary,
              ),
            )
          : Icon(icon),
    );
  }
}
