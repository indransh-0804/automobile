import 'package:flutter/material.dart';

class AMElevatedButton extends StatelessWidget {
  const AMElevatedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.prefixIcon,
    this.width,
    this.backgroundColor,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? prefixIcon;
  final double? width;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final indicatorSize = constraints.maxHeight.isFinite
              ? constraints.maxHeight * 0.45
              : 24.0;
          return ElevatedButton(
            onPressed: isLoading ? null : onPressed,
            style: backgroundColor != null
                ? ElevatedButton.styleFrom(backgroundColor: backgroundColor)
                : null,
            child: isLoading
                ? SizedBox(
                    width: indicatorSize,
                    height: indicatorSize,
                    child: const CircularProgressIndicator.adaptive(
                      strokeWidth: 2,
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (prefixIcon != null) ...[
                        Icon(prefixIcon, size: 18),
                        const SizedBox(width: 8),
                      ],
                      Text(label),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
