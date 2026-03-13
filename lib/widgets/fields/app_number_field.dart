import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppNumberField extends StatelessWidget {
  final String label;
  final String? hint;
  final String? helperText;
  final IconData? prefixIcon;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final bool enabled;
  final TextInputAction? textInputAction;

  const AppNumberField({
    super.key,
    required this.label,
    this.hint,
    this.helperText,
    this.prefixIcon,
    this.validator,
    this.controller,
    this.onChanged,
    this.enabled = true,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    if (controller == null) {
      return TextFormField(
        validator: validator,
        onChanged: onChanged,
        enabled: enabled,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
        ],
        textInputAction: textInputAction,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          helperText: helperText,
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        ),
      );
    }
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller!,
      builder: (context, value, _) {
        return TextFormField(
          controller: controller,
          validator: validator,
          onChanged: onChanged,
          enabled: enabled,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
          ],
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
