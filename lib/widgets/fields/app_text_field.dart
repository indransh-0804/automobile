import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final String? helperText;
  final IconData? prefixIcon;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final bool enabled;
  final int maxLines;
  final TextInputAction? textInputAction;

  const AppTextField({
    super.key,
    required this.label,
    this.hint,
    this.helperText,
    this.prefixIcon,
    this.validator,
    this.controller,
    this.onChanged,
    this.enabled = true,
    this.maxLines = 1,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller ?? TextEditingController(),
      builder: (context, value, _) {
        return TextFormField(
          controller: controller,
          validator: validator,
          onChanged: onChanged,
          enabled: enabled,
          maxLines: maxLines,
          textInputAction: textInputAction,
          decoration: InputDecoration(
            labelText: label,
            hintText: hint,
            helperText: helperText,
            prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
            suffixIcon: value.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      controller?.clear();
                      onChanged?.call('');
                    },
                  )
                : null,
          ),
        );
      },
    );
  }
}
