import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:automobile/core/constants/app_constants.dart';
import 'package:automobile/core/utils/validators.dart';
import 'package:automobile/models/car_model.dart';
import 'package:automobile/providers/car_provider.dart';
import 'package:automobile/widgets/fields/app_text_field.dart';
import 'package:automobile/widgets/fields/app_number_field.dart';
import 'package:automobile/widgets/buttons/app_elevated_button.dart';
import 'package:automobile/widgets/feedback/app_snackbar.dart';

class AddCarScreen extends ConsumerStatefulWidget {
  const AddCarScreen({super.key});

  @override
  ConsumerState<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends ConsumerState<AddCarScreen> {
  final _formKey = GlobalKey<FormState>();
  final _makeController = TextEditingController();
  final _modelController = TextEditingController();
  final _yearController = TextEditingController();
  final _colorController = TextEditingController();
  final _vinController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockCountController = TextEditingController();
  final _imageUrlController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _makeController.dispose();
    _modelController.dispose();
    _yearController.dispose();
    _colorController.dispose();
    _vinController.dispose();
    _priceController.dispose();
    _stockCountController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      final car = CarModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        make: _makeController.text.trim(),
        model: _modelController.text.trim(),
        year: int.parse(_yearController.text.trim()),
        color: _colorController.text.trim(),
        vin: _vinController.text.trim(),
        price: double.parse(_priceController.text.trim()),
        stockCount: int.parse(_stockCountController.text.trim()),
        status: CarStatus.available,
        imageUrl: _imageUrlController.text.trim(),
        createdAt: DateTime.now(),
      );
      await ref.read(carControllerProvider).addCar(car);
      if (mounted) {
        AppSnackbar.showSuccess(context, 'Car added successfully');
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
      appBar: AppBar(title: const Text('Add Car')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(padding),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              AppTextField(
                label: 'Make',
                hint: 'e.g. Toyota',
                controller: _makeController,
                validator: Validators.required,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: kBaseUnit * 2),
              AppTextField(
                label: 'Model',
                hint: 'e.g. Camry',
                controller: _modelController,
                validator: Validators.required,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: kBaseUnit * 2),
              AppNumberField(
                label: 'Year',
                hint: 'e.g. 2024',
                controller: _yearController,
                validator: Validators.number,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: kBaseUnit * 2),
              AppTextField(
                label: 'Color',
                hint: 'e.g. Silver',
                controller: _colorController,
                validator: Validators.required,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: kBaseUnit * 2),
              AppTextField(
                label: 'VIN',
                hint: 'Vehicle Identification Number',
                controller: _vinController,
                validator: Validators.required,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: kBaseUnit * 2),
              AppNumberField(
                label: 'Price',
                hint: 'e.g. 25000',
                controller: _priceController,
                validator: Validators.positiveNumber,
                prefixIcon: Icons.attach_money,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: kBaseUnit * 2),
              AppNumberField(
                label: 'Stock Count',
                hint: 'e.g. 5',
                controller: _stockCountController,
                validator: Validators.number,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: kBaseUnit * 2),
              AppTextField(
                label: 'Image URL',
                hint: 'Optional image URL',
                controller: _imageUrlController,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(height: kBaseUnit * 4),
              SizedBox(
                width: double.infinity,
                child: AppElevatedButton(
                  label: 'Add Car',
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
