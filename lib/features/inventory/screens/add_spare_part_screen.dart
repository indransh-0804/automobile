import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:automobile/core/constants/app_constants.dart';
import 'package:automobile/core/utils/validators.dart';
import 'package:automobile/models/spare_part_model.dart';
import 'package:automobile/providers/spare_part_provider.dart';
import 'package:automobile/widgets/fields/app_text_field.dart';
import 'package:automobile/widgets/fields/app_number_field.dart';
import 'package:automobile/widgets/buttons/app_elevated_button.dart';
import 'package:automobile/widgets/feedback/app_snackbar.dart';

class AddSparePartScreen extends ConsumerStatefulWidget {
  const AddSparePartScreen({super.key});

  @override
  ConsumerState<AddSparePartScreen> createState() => _AddSparePartScreenState();
}

class _AddSparePartScreenState extends ConsumerState<AddSparePartScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _partNumberController = TextEditingController();
  final _categoryController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockCountController = TextEditingController();
  final _lowStockThresholdController = TextEditingController();
  final _supplierIdController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _partNumberController.dispose();
    _categoryController.dispose();
    _priceController.dispose();
    _stockCountController.dispose();
    _lowStockThresholdController.dispose();
    _supplierIdController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      final part = SparePartModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text.trim(),
        partNumber: _partNumberController.text.trim(),
        category: _categoryController.text.trim(),
        price: double.parse(_priceController.text.trim()),
        stockCount: int.parse(_stockCountController.text.trim()),
        lowStockThreshold: int.parse(_lowStockThresholdController.text.trim()),
        supplierId: _supplierIdController.text.trim(),
        createdAt: DateTime.now(),
      );
      await ref.read(sparePartControllerProvider).addSparePart(part);
      if (mounted) {
        AppSnackbar.showSuccess(context, 'Spare part added successfully');
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        AppSnackbar.showError(context, e.toString());
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final padding = kBaseUnit * 2;

    return Scaffold(
      appBar: AppBar(title: const Text('Add Spare Part')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(padding),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              AppTextField(
                label: 'Name',
                hint: 'Part name',
                controller: _nameController,
                validator: Validators.required,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: kBaseUnit * 2),
              AppTextField(
                label: 'Part Number',
                hint: 'e.g. SP-001',
                controller: _partNumberController,
                validator: Validators.required,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: kBaseUnit * 2),
              AppTextField(
                label: 'Category',
                hint: 'e.g. Engine',
                controller: _categoryController,
                validator: Validators.required,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: kBaseUnit * 2),
              AppNumberField(
                label: 'Price',
                hint: 'e.g. 150.00',
                controller: _priceController,
                validator: Validators.positiveNumber,
                prefixIcon: Icons.attach_money,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: kBaseUnit * 2),
              AppNumberField(
                label: 'Stock Count',
                hint: 'e.g. 50',
                controller: _stockCountController,
                validator: Validators.number,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: kBaseUnit * 2),
              AppNumberField(
                label: 'Low Stock Threshold',
                hint: 'e.g. 10',
                controller: _lowStockThresholdController,
                validator: Validators.number,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: kBaseUnit * 2),
              AppTextField(
                label: 'Supplier ID',
                hint: 'Supplier identifier',
                controller: _supplierIdController,
                validator: Validators.required,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(height: kBaseUnit * 4),
              SizedBox(
                width: double.infinity,
                child: AppElevatedButton(
                  label: 'Add Spare Part',
                  isLoading: _isLoading,
                  onPressed: _submit,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
