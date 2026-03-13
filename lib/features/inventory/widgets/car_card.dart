import 'package:flutter/material.dart';
import 'package:automobile/core/constants/app_constants.dart';
import 'package:automobile/core/utils/formatters.dart';
import 'package:automobile/models/car_model.dart';
import 'package:automobile/widgets/display/app_badge.dart';

class CarCard extends StatelessWidget {
  final CarModel car;

  const CarCard({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Card(
      margin: EdgeInsets.only(bottom: kBaseUnit),
      child: Padding(
        padding: EdgeInsets.all(kBaseUnit * 2),
        child: Row(
          children: [
            Container(
              width: kBaseUnit * 7,
              height: kBaseUnit * 7,
              decoration: BoxDecoration(
                color: scheme.primaryContainer,
                borderRadius: BorderRadius.circular(kBaseUnit),
              ),
              child: Icon(
                Icons.directions_car,
                size: kBaseUnit * 4,
                color: scheme.onPrimaryContainer,
              ),
            ),
            SizedBox(width: kBaseUnit * 2),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${car.make} ${car.model}',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  SizedBox(height: kBaseUnit * 0.5),
                  Text(
                    '${car.year} • ${car.color}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  SizedBox(height: kBaseUnit * 0.5),
                  Text(
                    Formatters.formatCurrency(car.price),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            AppBadge(label: car.status.name),
          ],
        ),
      ),
    );
  }
}
