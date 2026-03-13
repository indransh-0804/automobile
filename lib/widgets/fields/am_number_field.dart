import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/app_colors.dart';

class AMNumberField extends StatefulWidget {
  const AMNumberField({
    super.key,
    required this.controller,
    required this.label,
    this.hint = '',
    this.helperText,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.onSuffixTap,
    this.validator,
    this.enabled = true,
    this.unit,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final String? helperText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onSuffixTap;
  final FormFieldValidator<String>? validator;
  final bool enabled;
  final String? unit;

  @override
  State<AMNumberField> createState() => _AMNumberFieldState();
}

class _AMNumberFieldState extends State<AMNumberField> {
  late final FocusNode _focusNode;
  late final ValueNotifier<bool> _hasFocus;
  late final ValueNotifier<bool> _hasText;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _hasFocus = ValueNotifier(false);
    _hasText = ValueNotifier(widget.controller.text.isNotEmpty);

    _focusNode.addListener(() {
      _hasFocus.value = _focusNode.hasFocus;
    });
    widget.controller.addListener(() {
      _hasText.value = widget.controller.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _hasFocus.dispose();
    _hasText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _hasFocus,
      builder: (context, hasFocus, _) {
        return ValueListenableBuilder<bool>(
          valueListenable: _hasText,
          builder: (context, hasText, _) {
            return TextFormField(
              controller: widget.controller,
              focusNode: _focusNode,
              enabled: widget.enabled,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
              ],
              onChanged: widget.onChanged,
              validator: widget.validator,
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: InputDecoration(
                labelText: widget.label,
                hintText: widget.hint,
                helperText: widget.helperText,
                prefixText: widget.unit,
                prefixIcon: widget.prefixIcon != null
                    ? Icon(
                        widget.prefixIcon,
                        color: hasFocus ? AppColors.accent : AppColors.onSurfaceMuted,
                      )
                    : null,
                suffixIcon: widget.enabled && hasText
                    ? IconButton(
                        icon: const Icon(Icons.close, color: AppColors.onSurfaceMuted),
                        onPressed: () {
                          widget.controller.clear();
                        },
                      )
                    : (widget.suffixIcon != null
                        ? IconButton(
                            icon: Icon(widget.suffixIcon, color: AppColors.onSurfaceMuted),
                            onPressed: widget.onSuffixTap,
                          )
                        : null),
              ),
            );
          },
        );
      },
    );
  }
}
