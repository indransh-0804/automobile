import 'package:flutter/material.dart';
import 'package:automobile/core/constants/app_constants.dart';

class AppStatCard extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle;
  final IconData icon;
  final Color? color;

  const AppStatCard({
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
    required this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final cardColor = color ?? scheme.surfaceContainerHighest;
    final padding = kBaseUnit * 2;
    final iconSize = kBaseUnit * 3;

    return Card(
      color: cardColor,
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: iconSize, color: scheme.primary),
            SizedBox(height: kBaseUnit),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: kBaseUnit * 0.5),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            if (subtitle != null) ...[
              SizedBox(height: kBaseUnit * 0.5),
              Text(
                subtitle!,
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
