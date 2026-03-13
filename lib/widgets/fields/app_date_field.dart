import 'package:flutter/material.dart';
import 'package:automobile/core/utils/formatters.dart';

class AppDateField extends StatefulWidget {
  final String label;
  final String? hint;
  final String? helperText;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final ValueChanged<DateTime>? onDateSelected;
  final String? Function(String?)? validator;
  final bool enabled;

  const AppDateField({
    super.key,
    required this.label,
    this.hint,
    this.helperText,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.onDateSelected,
    this.validator,
    this.enabled = true,
  });

  @override
  State<AppDateField> createState() => _AppDateFieldState();
}

class _AppDateFieldState extends State<AppDateField> {
  final TextEditingController _controller = TextEditingController();
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    if (widget.initialDate != null) {
      _selectedDate = widget.initialDate;
      _controller.text = Formatters.formatDate(widget.initialDate!);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: widget.firstDate ?? DateTime(2000),
      lastDate: widget.lastDate ?? DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _controller.text = Formatters.formatDate(picked);
      });
      widget.onDateSelected?.call(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      readOnly: true,
      onTap: widget.enabled ? _pickDate : null,
      validator: widget.validator,
      enabled: widget.enabled,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
        helperText: widget.helperText,
        prefixIcon: const Icon(Icons.calendar_today),
        suffixIcon: _controller.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _selectedDate = null;
                    _controller.clear();
                  });
                },
              )
            : null,
      ),
    );
  }
}
