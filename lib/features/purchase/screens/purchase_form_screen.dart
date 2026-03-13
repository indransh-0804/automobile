import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:automobile/core/constants/app_constants.dart';
import 'package:automobile/core/utils/validators.dart';
import 'package:automobile/models/purchase_model.dart';
import 'package:automobile/models/sale_model.dart';
import 'package:automobile/models/car_model.dart';
import 'package:automobile/providers/car_provider.dart';
import 'package:automobile/providers/purchase_provider.dart';
import 'package:automobile/providers/sale_provider.dart';
import 'package:automobile/core/services/pdf_service.dart';
import 'package:automobile/widgets/fields/app_text_field.dart';
import 'package:automobile/widgets/fields/app_number_field.dart';
import 'package:automobile/widgets/fields/app_date_field.dart';
import 'package:automobile/widgets/buttons/app_elevated_button.dart';
import 'package:automobile/widgets/feedback/app_snackbar.dart';
import 'package:automobile/widgets/display/app_loading_indicator.dart';

class PurchaseFormScreen extends ConsumerStatefulWidget {
  const PurchaseFormScreen({super.key});

  @override
  ConsumerState<PurchaseFormScreen> createState() => _PurchaseFormScreenState();
}

class _PurchaseFormScreenState extends ConsumerState<PurchaseFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _customerNameController = TextEditingController();
  final _customerIdController = TextEditingController();
  final _salePriceController = TextEditingController();
  final _notesController = TextEditingController();
  String? _selectedCarId;
  String _paymentMethod = 'Cash';
  DateTime _selectedDate = DateTime.now();
  bool _isLoading = false;
  PurchaseModel? _lastPurchase;
  CarModel? _lastCar;

  @override
  void dispose() {
    _customerNameController.dispose();
    _customerIdController.dispose();
    _salePriceController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedCarId == null) {
      AppSnackbar.showError(context, 'Please select a car');
      return;
    }
    setState(() => _isLoading = true);
    try {
      final cars = ref.read(carsProvider).value ?? [];
      final selectedCar = cars.firstWhere((c) => c.id == _selectedCarId);
      final purchaseId = DateTime.now().millisecondsSinceEpoch.toString();

      final purchase = PurchaseModel(
        id: purchaseId,
        customerId: _customerIdController.text.trim(),
        customerName: _customerNameController.text.trim(),
        carId: selectedCar.id,
        carName: '${selectedCar.make} ${selectedCar.model}',
        salePrice: double.parse(_salePriceController.text.trim()),
        paymentMethod: _paymentMethod,
        date: _selectedDate,
        employeeId: '',
        notes: _notesController.text.trim(),
      );

      await ref.read(purchaseControllerProvider).addPurchase(purchase);

      final sale = SaleModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        purchaseId: purchaseId,
        amount: purchase.salePrice,
        date: _selectedDate,
        paymentMethod: _paymentMethod,
        employeeId: '',
      );
      await ref.read(saleControllerProvider).addSale(sale);

      _lastPurchase = purchase;
      _lastCar = selectedCar;

      if (mounted) {
        AppSnackbar.showSuccess(context, 'Purchase recorded successfully');
      }
    } catch (e) {
      if (mounted) {
        AppSnackbar.showError(context, e.toString());
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _exportBill() async {
    if (_lastPurchase != null && _lastCar != null) {
      await PdfService.generatePurchaseBill(_lastPurchase!, _lastCar!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final carsAsync = ref.watch(carsProvider);
    final padding = kBaseUnit * 2;

    return Scaffold(
      appBar: AppBar(title: const Text('New Purchase')),
      body: carsAsync.when(
        data: (cars) {
          final availableCars =
              cars.where((c) => c.status == CarStatus.available).toList();

          return SingleChildScrollView(
            padding: EdgeInsets.all(padding),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  AppTextField(
                    label: 'Customer ID',
                    hint: 'Customer identifier',
                    controller: _customerIdController,
                    validator: Validators.required,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: kBaseUnit * 2),
                  AppTextField(
                    label: 'Customer Name',
                    hint: 'Full name',
                    controller: _customerNameController,
                    validator: Validators.required,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: kBaseUnit * 2),
                  DropdownButtonFormField<String>(
                    value: _selectedCarId,
                    decoration: const InputDecoration(
                      labelText: 'Select Car',
                      prefixIcon: Icon(Icons.directions_car),
                    ),
                    items: availableCars
                        .map((car) => DropdownMenuItem(
                              value: car.id,
                              child: Text('${car.make} ${car.model} (${car.year})'),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() => _selectedCarId = value);
                    },
                    validator: (value) =>
                        value == null ? 'Please select a car' : null,
                  ),
                  SizedBox(height: kBaseUnit * 2),
                  AppNumberField(
                    label: 'Sale Price',
                    hint: 'e.g. 25000',
                    controller: _salePriceController,
                    validator: Validators.positiveNumber,
                    prefixIcon: Icons.attach_money,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: kBaseUnit * 2),
                  DropdownButtonFormField<String>(
                    value: _paymentMethod,
                    decoration: const InputDecoration(
                      labelText: 'Payment Method',
                      prefixIcon: Icon(Icons.payment),
                    ),
                    items: ['Cash', 'Credit Card', 'Bank Transfer', 'Financing']
                        .map((method) => DropdownMenuItem(
                              value: method,
                              child: Text(method),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _paymentMethod = value);
                      }
                    },
                  ),
                  SizedBox(height: kBaseUnit * 2),
                  AppDateField(
                    label: 'Date',
                    initialDate: _selectedDate,
                    onDateSelected: (date) {
                      setState(() => _selectedDate = date);
                    },
                  ),
                  SizedBox(height: kBaseUnit * 2),
                  AppTextField(
                    label: 'Notes',
                    hint: 'Additional notes',
                    controller: _notesController,
                    maxLines: 3,
                    textInputAction: TextInputAction.done,
                  ),
                  SizedBox(height: kBaseUnit * 4),
                  SizedBox(
                    width: double.infinity,
                    child: AppElevatedButton(
                      label: 'Submit Purchase',
                      isLoading: _isLoading,
                      onPressed: _submit,
                    ),
                  ),
                  if (_lastPurchase != null) ...[
                    SizedBox(height: kBaseUnit * 2),
                    SizedBox(
                      width: double.infinity,
                      child: AppElevatedButton(
                        label: 'Export Bill',
                        prefixIcon: Icons.picture_as_pdf,
                        onPressed: _exportBill,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
        loading: () => const AppLoadingIndicator(),
        error: (error, _) => Center(child: Text(error.toString())),
      ),
    );
  }
}
