// lib/features/inventory/presentation/widgets/add_inventory_bottom_sheet.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_dimensions.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_snackbar.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../domain/enums/stock_status.dart';
import '../../domain/models/car_item.dart';
import '../../domain/models/part_item.dart';
import '../providers/inventory_provider.dart';

class AddInventoryBottomSheet extends ConsumerStatefulWidget {
  const AddInventoryBottomSheet({super.key});

  @override
  ConsumerState<AddInventoryBottomSheet> createState() =>
      _AddInventoryBottomSheetState();
}

class _AddInventoryBottomSheetState
    extends ConsumerState<AddInventoryBottomSheet>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _carMakeController = TextEditingController();
  final _carModelController = TextEditingController();
  final _carYearController = TextEditingController();
  final _carVariantController = TextEditingController();
  final _carColorController = TextEditingController();
  final _carVinController = TextEditingController();
  final _carPurchasePriceController = TextEditingController();
  final _carSellingPriceController = TextEditingController();
  final _carMileageController = TextEditingController();

  final _partNameController = TextEditingController();
  final _partNumberController = TextEditingController();
  final _partCategoryController = TextEditingController();
  final _partQuantityController = TextEditingController();
  final _partReorderLevelController = TextEditingController();
  final _partUnitCostController = TextEditingController();
  final _partSellingPriceController = TextEditingController();
  final _partSupplierController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _carMakeController.dispose();
    _carModelController.dispose();
    _carYearController.dispose();
    _carVariantController.dispose();
    _carColorController.dispose();
    _carVinController.dispose();
    _carPurchasePriceController.dispose();
    _carSellingPriceController.dispose();
    _carMileageController.dispose();
    _partNameController.dispose();
    _partNumberController.dispose();
    _partCategoryController.dispose();
    _partQuantityController.dispose();
    _partReorderLevelController.dispose();
    _partUnitCostController.dispose();
    _partSellingPriceController.dispose();
    _partSupplierController.dispose();
    super.dispose();
  }

  void _submitCar() {
    final car = CarItem(
      id: 'car-${DateTime.now().millisecondsSinceEpoch}',
      make: _carMakeController.text,
      model: _carModelController.text,
      year: int.tryParse(_carYearController.text) ?? DateTime.now().year,
      variant: _carVariantController.text,
      color: _carColorController.text,
      vin: _carVinController.text,
      purchasePrice:
          double.tryParse(_carPurchasePriceController.text) ?? 0,
      sellingPrice:
          double.tryParse(_carSellingPriceController.text) ?? 0,
      stockStatus: StockStatus.inStock,
      mileage: int.tryParse(_carMileageController.text) ?? 0,
      dateAdded: DateTime.now(),
      imageUrl: '',
    );

    ref.read(inventoryProvider.notifier).addCar(car);
    Navigator.of(context).pop();
    AppSnackbar.show(
      context,
      'Car added to inventory successfully',
      type: SnackbarType.success,
    );
  }

  void _submitPart() {
    final quantity = int.tryParse(_partQuantityController.text) ?? 0;
    final reorderLevel =
        int.tryParse(_partReorderLevelController.text) ?? 0;

    StockStatus status;
    if (quantity == 0) {
      status = StockStatus.outOfStock;
    } else if (quantity <= reorderLevel) {
      status = StockStatus.lowStock;
    } else {
      status = StockStatus.inStock;
    }

    final part = PartItem(
      id: 'part-${DateTime.now().millisecondsSinceEpoch}',
      name: _partNameController.text,
      partNumber: _partNumberController.text,
      category: _partCategoryController.text,
      compatibleModels: [],
      quantityInStock: quantity,
      reorderLevel: reorderLevel,
      unitCost: double.tryParse(_partUnitCostController.text) ?? 0,
      sellingPrice:
          double.tryParse(_partSellingPriceController.text) ?? 0,
      stockStatus: status,
      supplier: _partSupplierController.text,
      dateAdded: DateTime.now(),
    );

    ref.read(inventoryProvider.notifier).addPart(part);
    Navigator.of(context).pop();
    AppSnackbar.show(
      context,
      'Part added to inventory successfully',
      type: SnackbarType.success,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * AppDimensions.bottomSheetHeightFactor,
        child: Column(
          children: [
            SizedBox(height: AppDimensions.spacingSm),
            Container(
              width: AppDimensions.spacingXl,
              height: AppDimensions.spacingXs,
              decoration: BoxDecoration(
                color: theme.colorScheme.onSurfaceVariant,
                borderRadius:
                    BorderRadius.circular(AppDimensions.radiusFull),
              ),
            ),
            SizedBox(height: AppDimensions.spacingMd),
            Text(
              'Add Inventory',
              style: GoogleFonts.syne(
                fontSize: AppDimensions.fontSizeXl,
                fontWeight: FontWeight.w700,
                color: theme.colorScheme.onSurface,
              ),
            ),
            SizedBox(height: AppDimensions.spacingMd),
            TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: 'Add Car'),
                Tab(text: 'Add Part'),
              ],
              labelStyle: GoogleFonts.syne(
                fontWeight: FontWeight.w600,
                fontSize: AppDimensions.fontSizeMd,
              ),
              indicatorSize: TabBarIndicatorSize.label,
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildCarForm(),
                  _buildPartForm(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCarForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimensions.spacingMd),
      child: Column(
        children: [
          AppTextField(
            label: 'Make',
            hint: 'e.g. Toyota',
            controller: _carMakeController,
          ),
          SizedBox(height: AppDimensions.spacingMd),
          AppTextField(
            label: 'Model',
            hint: 'e.g. Camry',
            controller: _carModelController,
          ),
          SizedBox(height: AppDimensions.spacingMd),
          AppTextField(
            label: 'Year',
            hint: 'e.g. 2024',
            controller: _carYearController,
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: AppDimensions.spacingMd),
          AppTextField(
            label: 'Variant',
            hint: 'e.g. XLE V6',
            controller: _carVariantController,
          ),
          SizedBox(height: AppDimensions.spacingMd),
          AppTextField(
            label: 'Color',
            hint: 'e.g. Silver',
            controller: _carColorController,
          ),
          SizedBox(height: AppDimensions.spacingMd),
          AppTextField(
            label: 'VIN',
            hint: 'Vehicle Identification Number',
            controller: _carVinController,
          ),
          SizedBox(height: AppDimensions.spacingMd),
          AppTextField(
            label: 'Purchase Price',
            hint: 'e.g. 28500',
            controller: _carPurchasePriceController,
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: AppDimensions.spacingMd),
          AppTextField(
            label: 'Selling Price',
            hint: 'e.g. 34999',
            controller: _carSellingPriceController,
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: AppDimensions.spacingMd),
          AppTextField(
            label: 'Mileage',
            hint: 'e.g. 1200',
            controller: _carMileageController,
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: AppDimensions.spacingLg),
          AppButton(
            label: 'Add to Inventory',
            variant: AppButtonVariant.primary,
            isFullWidth: true,
            onPressed: _submitCar,
          ),
          SizedBox(height: AppDimensions.spacingMd),
        ],
      ),
    );
  }

  Widget _buildPartForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimensions.spacingMd),
      child: Column(
        children: [
          AppTextField(
            label: 'Name',
            hint: 'e.g. Brake Pad Set',
            controller: _partNameController,
          ),
          SizedBox(height: AppDimensions.spacingMd),
          AppTextField(
            label: 'Part Number',
            hint: 'e.g. BP-2024-001',
            controller: _partNumberController,
          ),
          SizedBox(height: AppDimensions.spacingMd),
          AppTextField(
            label: 'Category',
            hint: 'e.g. Brakes',
            controller: _partCategoryController,
          ),
          SizedBox(height: AppDimensions.spacingMd),
          AppTextField(
            label: 'Quantity',
            hint: 'e.g. 45',
            controller: _partQuantityController,
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: AppDimensions.spacingMd),
          AppTextField(
            label: 'Reorder Level',
            hint: 'e.g. 10',
            controller: _partReorderLevelController,
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: AppDimensions.spacingMd),
          AppTextField(
            label: 'Unit Cost',
            hint: 'e.g. 35.00',
            controller: _partUnitCostController,
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: AppDimensions.spacingMd),
          AppTextField(
            label: 'Selling Price',
            hint: 'e.g. 65.00',
            controller: _partSellingPriceController,
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: AppDimensions.spacingMd),
          AppTextField(
            label: 'Supplier',
            hint: 'e.g. AutoParts Direct',
            controller: _partSupplierController,
          ),
          SizedBox(height: AppDimensions.spacingLg),
          AppButton(
            label: 'Add to Inventory',
            variant: AppButtonVariant.primary,
            isFullWidth: true,
            onPressed: _submitPart,
          ),
          SizedBox(height: AppDimensions.spacingMd),
        ],
      ),
    );
  }
}
