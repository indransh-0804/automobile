import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:automobile/core/constants/app_constants.dart';
import 'package:automobile/core/utils/validators.dart';
import 'package:automobile/models/service_appointment_model.dart';
import 'package:automobile/providers/appointment_provider.dart';
import 'package:automobile/widgets/fields/app_text_field.dart';
import 'package:automobile/widgets/fields/app_date_field.dart';
import 'package:automobile/widgets/buttons/app_elevated_button.dart';
import 'package:automobile/widgets/feedback/app_snackbar.dart';

class AppointmentFormScreen extends ConsumerStatefulWidget {
  const AppointmentFormScreen({super.key});

  @override
  ConsumerState<AppointmentFormScreen> createState() =>
      _AppointmentFormScreenState();
}

class _AppointmentFormScreenState
    extends ConsumerState<AppointmentFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _customerNameController = TextEditingController();
  final _customerIdController = TextEditingController();
  final _carIdController = TextEditingController();
  final _serviceTypeController = TextEditingController();
  final _technicianController = TextEditingController();
  final _notesController = TextEditingController();
  DateTime _scheduledAt = DateTime.now();
  bool _isLoading = false;

  @override
  void dispose() {
    _customerNameController.dispose();
    _customerIdController.dispose();
    _carIdController.dispose();
    _serviceTypeController.dispose();
    _technicianController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      final appointment = ServiceAppointmentModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        customerId: _customerIdController.text.trim(),
        customerName: _customerNameController.text.trim(),
        carId: _carIdController.text.trim(),
        serviceType: _serviceTypeController.text.trim(),
        scheduledAt: _scheduledAt,
        status: AppointmentStatus.pending,
        technicianId: _technicianController.text.trim(),
        notes: _notesController.text.trim(),
      );

      await ref
          .read(appointmentControllerProvider)
          .addAppointment(appointment);
      if (mounted) {
        AppSnackbar.showSuccess(context, 'Appointment created successfully');
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
      appBar: AppBar(title: const Text('New Appointment')),
      body: SingleChildScrollView(
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
              AppTextField(
                label: 'Car ID',
                controller: _carIdController,
                validator: Validators.required,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: kBaseUnit * 2),
              AppTextField(
                label: 'Service Type',
                hint: 'e.g. Oil Change, Brake Inspection',
                controller: _serviceTypeController,
                validator: Validators.required,
                textInputAction: TextInputAction.next,
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
                label: 'Technician',
                controller: _technicianController,
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
                  label: 'Create Appointment',
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
