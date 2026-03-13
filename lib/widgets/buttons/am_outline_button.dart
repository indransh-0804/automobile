import 'package:flutter/material.dart';

class AMOutlineButton extends StatelessWidget {
  const AMOutlineButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.prefixIcon,
    this.width,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? prefixIcon;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final indicatorSize = constraints.maxHeight.isFinite
              ? constraints.maxHeight * 0.45
              : 24.0;
          return OutlinedButton(
            onPressed: isLoading ? null : onPressed,
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
