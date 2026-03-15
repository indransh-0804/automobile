// lib/features/inventory/presentation/widgets/part_inventory_card.dart
import 'package:flutter/material.dart';

import '../../../../core/theme/app_dimensions.dart';
import '../../../../shared/widgets/app_badge.dart';
import '../../../../shared/widgets/app_data_chip.dart';
import '../../../../shared/widgets/app_snackbar.dart';
import '../../domain/models/part_item.dart';
import 'stock_status_indicator.dart';

class PartInventoryCard extends StatelessWidget {
  final PartItem part;

  const PartInventoryCard({
    super.key,
    required this.part,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLowStock = part.quantityInStock <= part.reorderLevel;

    return GestureDetector(
      onTap: () => AppSnackbar.show(
        context,
        'Part Number: ${part.partNumber}',
        type: SnackbarType.info,
      ),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (isLowStock)
                Container(
                  width: AppDimensions.colorSwatchWidth,
                  color: theme.colorScheme.errorContainer,
                ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(AppDimensions.spacingMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                part.name,
                                style: theme.textTheme.titleMedium,
                              ),
                              SizedBox(height: AppDimensions.spacingXs),
                              Text(
                                part.partNumber,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  fontFamily: AppDimensions.monoFontFamily,
                                  fontSize: AppDimensions.fontSizeXs,
                                  color: theme.colorScheme.onSurfaceVariant,
                                  letterSpacing: AppDimensions.letterSpacingWide,
                                ),
                              ),
                            ],
                          ),
                        ),
                        StockStatusIndicator(status: part.stockStatus),
                      ],
                    ),
                    SizedBox(height: AppDimensions.spacingSm),
                    Row(
                      children: [
                        AppBadge(label: part.category),
                        SizedBox(width: AppDimensions.spacingSm),
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: part.compatibleModels
                                  .map(
                                    (model) => Padding(
                                      padding: const EdgeInsets.only(
                                        right: AppDimensions.spacingXs,
                                      ),
                                      child: AppBadge(
                                        label: model,
                                        color:
                                            theme.colorScheme.surfaceContainerHigh,
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppDimensions.spacingSm),
                    Wrap(
                      spacing: AppDimensions.spacingSm,
                      runSpacing: AppDimensions.spacingXs,
                      children: [
                        AppDataChip(
                          label: 'Qty',
                          value: '${part.quantityInStock}',
                          valueColor: isLowStock
                              ? theme.colorScheme.error
                              : null,
                        ),
                        AppDataChip(
                          label: 'Reorder Lvl',
                          value: '${part.reorderLevel}',
                        ),
                        AppDataChip(
                          label: 'Unit Cost',
                          value: '\$${part.unitCost.toStringAsFixed(2)}',
                        ),
                        AppDataChip(
                          label: 'Selling',
                          value: '\$${part.sellingPrice.toStringAsFixed(2)}',
                          valueColor: theme.colorScheme.primary,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
          ),
        ),
      ),
    );
  }
}
