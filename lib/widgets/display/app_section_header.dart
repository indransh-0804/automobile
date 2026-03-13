import 'package:flutter/material.dart';

class AppSectionHeader extends StatelessWidget {
  final String title;
  final String? trailingLabel;
  final VoidCallback? onTrailingTap;

  const AppSectionHeader({
    super.key,
    required this.title,
    this.trailingLabel,
    this.onTrailingTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        if (trailingLabel != null)
          TextButton(
            onPressed: onTrailingTap,
            child: Text(trailingLabel!),
          ),
      ],
    );
  }
}
