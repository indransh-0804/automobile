import 'package:flutter/material.dart';
import 'package:automobile/core/utils/extensions.dart';

class QuickActionGrid extends StatelessWidget {
  const QuickActionGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final actions = [
      _QuickAction(icon: Icons.directions_car, label: 'Add Car'),
      _QuickAction(icon: Icons.shopping_cart, label: 'New Purchase'),
      _QuickAction(icon: Icons.speed, label: 'Book Test Drive'),
      _QuickAction(icon: Icons.calendar_month, label: 'New Appointment'),
      _QuickAction(icon: Icons.build, label: 'Add Spare Part'),
      _QuickAction(icon: Icons.account_balance, label: 'View Loans'),
    ];

    final aspectRatio = context.screenWidth / (context.screenWidth * 0.65);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.paddingMedium),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: aspectRatio,
          crossAxisSpacing: context.paddingSmall,
          mainAxisSpacing: context.paddingSmall,
        ),
        itemCount: actions.length,
        itemBuilder: (context, index) {
          final action = actions[index];
          return Card(
            child: InkWell(
              borderRadius: BorderRadius.circular(context.radiusMedium),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Coming soon: ${action.label}'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.all(context.paddingMedium),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      action.icon,
                      size: context.iconLarge,
                      color: context.colorScheme.primary,
                    ),
                    SizedBox(height: context.paddingSmall),
                    Text(
                      action.label,
                      style: context.textTheme.labelLarge,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _QuickAction {
  final IconData icon;
  final String label;

  const _QuickAction({required this.icon, required this.label});
}
