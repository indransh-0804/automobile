import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:automobile/core/router/route_names.dart';
import 'package:automobile/core/constants/app_constants.dart';

class QuickActionGrid extends StatelessWidget {
  const QuickActionGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final childAspectRatio = screenWidth / (screenWidth * 0.6);

    final actions = [
      _QuickAction(
        icon: Icons.directions_car,
        label: 'Add Car',
        onTap: () => context.goNamed(RouteNames.addCar),
      ),
      _QuickAction(
        icon: Icons.shopping_cart,
        label: 'New Purchase',
        onTap: () => context.goNamed(RouteNames.purchaseForm),
      ),
      _QuickAction(
        icon: Icons.car_rental,
        label: 'Book Test Drive',
        onTap: () => context.goNamed(RouteNames.testDriveForm),
      ),
      _QuickAction(
        icon: Icons.calendar_today,
        label: 'New Appointment',
        onTap: () => context.goNamed(RouteNames.appointmentForm),
      ),
      _QuickAction(
        icon: Icons.settings,
        label: 'Add Spare Part',
        onTap: () => context.goNamed(RouteNames.addSparePart),
      ),
      _QuickAction(
        icon: Icons.account_balance,
        label: 'View Loans',
        onTap: () => context.goNamed(RouteNames.loans),
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: childAspectRatio,
        crossAxisSpacing: kBaseUnit,
        mainAxisSpacing: kBaseUnit,
      ),
      itemCount: actions.length,
      itemBuilder: (context, index) {
        final action = actions[index];
        return Card(
          child: InkWell(
            onTap: action.onTap,
            borderRadius: BorderRadius.circular(kBaseUnit * 1.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  action.icon,
                  size: kBaseUnit * 3.5,
                  color: Theme.of(context).colorScheme.primary,
                ),
                SizedBox(height: kBaseUnit),
                Text(
                  action.label,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _QuickAction {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  _QuickAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });
}
