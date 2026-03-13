import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:automobile/core/constants/app_constants.dart';
import 'package:automobile/core/utils/validators.dart';
import 'package:automobile/models/test_drive_model.dart';
import 'package:automobile/providers/test_drive_provider.dart';
import 'package:automobile/providers/car_provider.dart';
import 'package:automobile/widgets/fields/app_text_field.dart';
import 'package:automobile/widgets/fields/app_date_field.dart';
import 'package:automobile/widgets/buttons/app_elevated_button.dart';
import 'package:automobile/widgets/feedback/app_snackbar.dart';
import 'package:automobile/widgets/display/app_loading_indicator.dart';

class TestDriveFormScreen extends ConsumerStatefulWidget {
  const TestDriveFormScreen({super.key});

  @override
  ConsumerState<TestDriveFormScreen> createState() =>
      _TestDriveFormScreenState();
}

class _TestDriveFormScreenState extends ConsumerState<TestDriveFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _customerNameController = TextEditingController();
  final _customerIdController = TextEditingController();
  final _employeeController = TextEditingController();
  final _notesController = TextEditingController();
  String? _selectedCarId;
  DateTime _scheduledAt = DateTime.now();
  bool _isLoading = false;

  @override
  void dispose() {
    _customerNameController.dispose();
    _customerIdController.dispose();
    _employeeController.dispose();
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

      final testDrive = TestDriveModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        customerId: _customerIdController.text.trim(),
        customerName: _customerNameController.text.trim(),
        carId: selectedCar.id,
        carName: '${selectedCar.make} ${selectedCar.model}',
        scheduledAt: _scheduledAt,
        employeeId: _employeeController.text.trim(),
        status: TestDriveStatus.scheduled,
        notes: _notesController.text.trim(),
      );

      await ref.read(testDriveControllerProvider).addTestDrive(testDrive);
      if (mounted) {
        AppSnackbar.showSuccess(context, 'Test drive booked successfully');
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
      appBar: AppBar(title: const Text('Book Test Drive')),
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
                  AppDateField(
                    label: 'Scheduled Date',
                    initialDate: _scheduledAt,
                    onDateSelected: (date) {
                      setState(() => _scheduledAt = date);
                    },
                  ),
                  SizedBox(height: kBaseUnit * 2),
                  AppTextField(
                    label: 'Employee',
                    controller: _employeeController,
                    validator: Validators.required,
                    textInputAction: TextInputAction.next,
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
                      label: 'Book Test Drive',
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
