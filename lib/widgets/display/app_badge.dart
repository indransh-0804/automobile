import 'package:flutter/material.dart';
import 'package:automobile/core/constants/app_constants.dart';

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
    final scheme = Theme.of(context).colorScheme;
    final bgColor = color ?? scheme.secondaryContainer;
    final fgColor = color != null
        ? ThemeData.estimateBrightnessForColor(color!) == Brightness.dark
            ? Colors.white
            : Colors.black
        : scheme.onSecondaryContainer;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: kBaseUnit,
        vertical: kBaseUnit * 0.5,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(kBaseUnit * 0.5),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: fgColor,
            ),
      ),
    );
  }
}
