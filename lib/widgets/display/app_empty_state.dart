import 'package:flutter/material.dart';
import 'package:automobile/core/constants/app_constants.dart';

class AppEmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const AppEmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final iconSize = kBaseUnit * 6;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: iconSize,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          SizedBox(height: kBaseUnit * 2),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: kBaseUnit),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
