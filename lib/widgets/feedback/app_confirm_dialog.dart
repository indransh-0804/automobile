import 'package:flutter/material.dart';
import 'package:automobile/widgets/buttons/app_elevated_button.dart';
import 'package:automobile/widgets/buttons/app_outline_button.dart';

class AppConfirmDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmLabel;
  final String cancelLabel;

  const AppConfirmDialog({
    super.key,
    required this.title,
    required this.message,
    this.confirmLabel = 'Confirm',
    this.cancelLabel = 'Cancel',
  });

  static Future<bool> show(
    BuildContext context, {
    required String title,
    required String message,
    String confirmLabel = 'Confirm',
    String cancelLabel = 'Cancel',
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (_) => AppConfirmDialog(
        title: title,
        message: message,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        AppOutlineButton(
          label: cancelLabel,
          onPressed: () => Navigator.of(context).pop(false),
        ),
        AppElevatedButton(
          label: confirmLabel,
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    );
  }
}
