import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:automobile/core/constants/app_constants.dart';
import 'package:automobile/core/utils/validators.dart';
import 'package:automobile/models/loan_model.dart';
import 'package:automobile/providers/loan_provider.dart';
import 'package:automobile/providers/car_provider.dart';
import 'package:automobile/widgets/fields/app_text_field.dart';
import 'package:automobile/widgets/fields/app_number_field.dart';
import 'package:automobile/widgets/fields/app_date_field.dart';
import 'package:automobile/widgets/buttons/app_elevated_button.dart';
import 'package:automobile/widgets/feedback/app_snackbar.dart';
import 'package:automobile/widgets/display/app_loading_indicator.dart';

class LoanFormScreen extends ConsumerStatefulWidget {
  const LoanFormScreen({super.key});

  @override
  ConsumerState<LoanFormScreen> createState() => _LoanFormScreenState();
}

class _LoanFormScreenState extends ConsumerState<LoanFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _customerIdController = TextEditingController();
  final _customerNameController = TextEditingController();
  final _principalController = TextEditingController();
  final _interestRateController = TextEditingController();
  final _termMonthsController = TextEditingController();
  final _monthlyPaymentController = TextEditingController();
  String? _selectedCarId;
  DateTime _startDate = DateTime.now();
  bool _isLoading = false;

  @override
  void dispose() {
    _customerIdController.dispose();
    _customerNameController.dispose();
    _principalController.dispose();
    _interestRateController.dispose();
    _termMonthsController.dispose();
    _monthlyPaymentController.dispose();
    super.dispose();
  }

  void _calculateMonthlyPayment() {
    final principal = double.tryParse(_principalController.text);
    final interestRate = double.tryParse(_interestRateController.text);
    final termMonths = int.tryParse(_termMonthsController.text);

    if (principal != null && interestRate != null && termMonths != null && termMonths > 0) {
      final monthlyRate = interestRate / 100 / 12;
      final payment = monthlyRate > 0
          ? (principal * monthlyRate * math.pow(1 + monthlyRate, termMonths)) /
              (math.pow(1 + monthlyRate, termMonths) - 1)
          : principal / termMonths;
      _monthlyPaymentController.text = payment.toStringAsFixed(2);
    }
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

      final loan = LoanModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        customerId: _customerIdController.text.trim(),
        customerName: _customerNameController.text.trim(),
        carId: selectedCar.id,
        carName: '${selectedCar.make} ${selectedCar.model}',
        principal: double.parse(_principalController.text.trim()),
        interestRate: double.parse(_interestRateController.text.trim()),
        termMonths: int.parse(_termMonthsController.text.trim()),
        monthlyPayment: double.parse(_monthlyPaymentController.text.trim()),
        startDate: _startDate,
        status: LoanStatus.active,
      );

      await ref.read(loanControllerProvider).addLoan(loan);
      if (mounted) {
        AppSnackbar.showSuccess(context, 'Loan created successfully');
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
    final carsAsync = ref.watch(carsProvider);
    final padding = kBaseUnit * 2;

    return Scaffold(
      appBar: AppBar(title: const Text('New Loan')),
      body: carsAsync.when(
        data: (cars) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(padding),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  AppTextField(
                    label: 'Customer ID',
                    controller: _customerIdController,
                    validator: Validators.required,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: kBaseUnit * 2),
                  AppTextField(
                    label: 'Customer Name',
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
                    items: cars
                        .map((car) => DropdownMenuItem(
                              value: car.id,
                              child: Text(
                                  '${car.make} ${car.model} (${car.year})'),
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
                    label: 'Principal Amount',
                    controller: _principalController,
                    validator: Validators.positiveNumber,
                    prefixIcon: Icons.attach_money,
                    onChanged: (_) => _calculateMonthlyPayment(),
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: kBaseUnit * 2),
                  AppNumberField(
                    label: 'Interest Rate (%)',
                    controller: _interestRateController,
                    validator: Validators.positiveNumber,
                    onChanged: (_) => _calculateMonthlyPayment(),
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: kBaseUnit * 2),
                  AppNumberField(
                    label: 'Term (Months)',
                    controller: _termMonthsController,
                    validator: Validators.positiveNumber,
                    onChanged: (_) => _calculateMonthlyPayment(),
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: kBaseUnit * 2),
                  AppNumberField(
                    label: 'Monthly Payment',
                    controller: _monthlyPaymentController,
                    enabled: false,
                  ),
                  SizedBox(height: kBaseUnit * 2),
                  AppDateField(
                    label: 'Start Date',
                    initialDate: _startDate,
                    onDateSelected: (date) {
                      setState(() => _startDate = date);
                    },
                  ),
                  SizedBox(height: kBaseUnit * 4),
                  SizedBox(
                    width: double.infinity,
                    child: AppElevatedButton(
                      label: 'Create Loan',
                      isLoading: _isLoading,
                      onPressed: _submit,
                    ),
                  ),
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
