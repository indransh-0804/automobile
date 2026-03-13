import 'package:flutter/material.dart';
import 'package:automobile/core/constants/app_constants.dart';
import 'package:automobile/core/utils/formatters.dart';
import 'package:automobile/models/car_model.dart';
import 'package:automobile/widgets/display/app_badge.dart';

class CatalogCarCard extends StatelessWidget {
  final CarModel car;

  const CatalogCarCard({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              color: scheme.surfaceContainerHighest,
              child: car.imageUrl.isNotEmpty
                  ? Image.network(
                      car.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Center(
                        child: Icon(
                          Icons.directions_car,
                          size: kBaseUnit * 5,
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    )
                  : Center(
                      child: Icon(
                        Icons.directions_car,
                        size: kBaseUnit * 5,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(kBaseUnit),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${car.make} ${car.model}',
                    style: Theme.of(context).textTheme.titleSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: kBaseUnit * 0.5),
                  Text(
                    '${car.year} • ${Formatters.formatCurrency(car.price)}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const Spacer(),
                  AppBadge(label: car.status.name),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
