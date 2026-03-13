import 'package:flutter/material.dart';

class AppPasswordField extends StatefulWidget {
  final String label;
  final String? hint;
  final String? helperText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final bool enabled;
  final TextInputAction? textInputAction;

  const AppPasswordField({
    super.key,
    required this.label,
    this.hint,
    this.helperText,
    this.validator,
    this.controller,
    this.onChanged,
    this.enabled = true,
    this.textInputAction,
  });

  @override
  State<AppPasswordField> createState() => _AppPasswordFieldState();
}

class _AppPasswordFieldState extends State<AppPasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      onChanged: widget.onChanged,
      enabled: widget.enabled,
      obscureText: _obscureText,
      textInputAction: widget.textInputAction,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
        helperText: widget.helperText,
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
    );
  }
}
