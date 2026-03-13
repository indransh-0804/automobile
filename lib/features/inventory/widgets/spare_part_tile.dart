import 'package:flutter/material.dart';
import 'package:automobile/core/constants/app_constants.dart';
import 'package:automobile/core/utils/formatters.dart';
import 'package:automobile/models/spare_part_model.dart';

class SparePartTile extends StatelessWidget {
  final SparePartModel sparePart;

  const SparePartTile({super.key, required this.sparePart});

  @override
  Widget build(BuildContext context) {
    final isLowStock = sparePart.stockCount <= sparePart.lowStockThreshold;
    final scheme = Theme.of(context).colorScheme;

    return Card(
      margin: EdgeInsets.only(bottom: kBaseUnit),
      child: ListTile(
        leading: Container(
          width: kBaseUnit * 5,
          height: kBaseUnit * 5,
          decoration: BoxDecoration(
            color: isLowStock ? scheme.errorContainer : scheme.secondaryContainer,
            borderRadius: BorderRadius.circular(kBaseUnit),
          ),
          child: Icon(
            Icons.settings,
            color: isLowStock ? scheme.onErrorContainer : scheme.onSecondaryContainer,
          ),
        ),
        title: Text(sparePart.name),
        subtitle: Text(
          '${sparePart.partNumber} • ${sparePart.category}',
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              Formatters.formatCurrency(sparePart.price),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              'Stock: ${sparePart.stockCount}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isLowStock ? scheme.error : null,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
