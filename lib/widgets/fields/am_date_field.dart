import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_colors.dart';

class AMDateField extends StatefulWidget {
  const AMDateField({
    super.key,
    required this.controller,
    required this.label,
    required this.firstDate,
    required this.lastDate,
    this.hint = '',
    this.helperText,
    this.onDateSelected,
    this.validator,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final String? helperText;
  final DateTime firstDate;
  final DateTime lastDate;
  final ValueChanged<DateTime>? onDateSelected;
  final FormFieldValidator<String>? validator;

  @override
  State<AMDateField> createState() => _AMDateFieldState();
}

class _AMDateFieldState extends State<AMDateField> {
  late final FocusNode _focusNode;
  late final ValueNotifier<bool> _hasFocus;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _hasFocus = ValueNotifier(false);
    _focusNode.addListener(() {
      _hasFocus.value = _focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _hasFocus.dispose();
    super.dispose();
  }

  Future<void> _pickDate(BuildContext context) async {
    _focusNode.requestFocus();
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
    );
    if (!context.mounted) return;
    _focusNode.unfocus();
    if (picked != null) {
      widget.controller.text = DateFormat('dd MMM yyyy').format(picked);
      widget.onDateSelected?.call(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _hasFocus,
      builder: (context, hasFocus, _) {
        return TextFormField(
          controller: widget.controller,
          focusNode: _focusNode,
          readOnly: true,
          onTap: () => _pickDate(context),
          validator: widget.validator,
          style: Theme.of(context).textTheme.bodyMedium,
          decoration: InputDecoration(
            labelText: widget.label,
            hintText: widget.hint,
            helperText: widget.helperText,
            prefixIcon: Icon(
              Icons.calendar_today,
              color: hasFocus ? AppColors.accent : AppColors.onSurfaceMuted,
            ),
          ),
        );
      },
    );
  }
}
