// lib/features/inventory/presentation/widgets/car_inventory_card.dart
import 'package:flutter/material.dart';

import '../../../../core/theme/app_dimensions.dart';
import '../../../../shared/widgets/app_data_chip.dart';
import '../../../../shared/widgets/app_snackbar.dart';
import '../../domain/models/car_item.dart';
import 'stock_status_indicator.dart';

class CarInventoryCard extends StatelessWidget {
  final CarItem car;

  const CarInventoryCard({
    super.key,
    required this.car,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => AppSnackbar.show(
        context,
        'VIN: ${car.vin}',
        type: SnackbarType.info,
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spacingMd),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: AppDimensions.carColorSwatchSize,
                    height: AppDimensions.carColorSwatchSize,
                    decoration: BoxDecoration(
                      color: _mapColorName(car.color),
                      borderRadius:
                          BorderRadius.circular(AppDimensions.radiusSm),
                    ),
                  ),
                  SizedBox(height: AppDimensions.spacingXs),
                  Icon(
                    Icons.directions_car,
                    size: AppDimensions.iconSizeMd,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
              SizedBox(width: AppDimensions.spacingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            '${car.make} ${car.model}',
                            style: theme.textTheme.titleMedium,
                          ),
                        ),
                        StockStatusIndicator(status: car.stockStatus),
                      ],
                    ),
                    SizedBox(height: AppDimensions.spacingXs),
                    Text(
                      '${car.variant} · ${car.year}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    SizedBox(height: AppDimensions.spacingXs),
                    Text(
                      car.vin,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontFamily: AppDimensions.monoFontFamily,
                        fontSize: AppDimensions.fontSizeXs,
                        color: theme.colorScheme.onSurfaceVariant,
                        letterSpacing: AppDimensions.letterSpacingWide,
                      ),
                    ),
                    SizedBox(height: AppDimensions.spacingSm),
                    Wrap(
                      spacing: AppDimensions.spacingSm,
                      runSpacing: AppDimensions.spacingXs,
                      children: [
                        AppDataChip(
                          label: 'Purchase',
                          value: '\$${car.purchasePrice.toStringAsFixed(0)}',
                        ),
                        AppDataChip(
                          label: 'Selling',
                          value: '\$${car.sellingPrice.toStringAsFixed(0)}',
                          valueColor: theme.colorScheme.primary,
                        ),
                        AppDataChip(
                          label: 'Mileage',
                          value: '${car.mileage} km',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _mapColorName(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'black':
        return const Color(0xFF212121);
      case 'white':
        return const Color(0xFFEEEEEE);
      case 'silver':
        return const Color(0xFFBDBDBD);
      case 'grey':
      case 'gray':
        return const Color(0xFF757575);
      case 'red':
        return const Color(0xFFC62828);
      case 'blue':
        return const Color(0xFF1565C0);
      case 'green':
        return const Color(0xFF2E7D32);
      case 'yellow':
        return const Color(0xFFF9A825);
      default:
        return const Color(0xFF9E9E9E);
    }
  }
}
