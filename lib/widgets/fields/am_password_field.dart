import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class AMPasswordField extends StatefulWidget {
  const AMPasswordField({
    super.key,
    required this.controller,
    required this.label,
    this.hint = '',
    this.helperText,
    this.validator,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final String? helperText;
  final FormFieldValidator<String>? validator;

  @override
  State<AMPasswordField> createState() => _AMPasswordFieldState();
}

class _AMPasswordFieldState extends State<AMPasswordField> {
  bool _obscure = true;
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

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _hasFocus,
      builder: (context, hasFocus, _) {
        return TextFormField(
          controller: widget.controller,
          focusNode: _focusNode,
          obscureText: _obscure,
          validator: widget.validator,
          style: Theme.of(context).textTheme.bodyMedium,
          decoration: InputDecoration(
            labelText: widget.label,
            hintText: widget.hint,
            helperText: widget.helperText,
            prefixIcon: Icon(
              Icons.lock_outline,
              color: hasFocus ? AppColors.accent : AppColors.onSurfaceMuted,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                color: hasFocus ? AppColors.accent : AppColors.onSurfaceMuted,
              ),
              onPressed: () {
                setState(() => _obscure = !_obscure);
              },
            ),
          ),
        );
      },
    );
  }
}
