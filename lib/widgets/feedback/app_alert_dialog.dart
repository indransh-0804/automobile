import 'package:flutter/material.dart';
import 'package:automobile/widgets/buttons/app_elevated_button.dart';

class AppAlertDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmLabel;
  final VoidCallback? onConfirm;

  const AppAlertDialog({
    super.key,
    required this.title,
    required this.message,
    this.confirmLabel = 'OK',
    this.onConfirm,
  });

  static Future<void> show(
    BuildContext context, {
    required String title,
    required String message,
    String confirmLabel = 'OK',
    VoidCallback? onConfirm,
  }) {
    return showDialog(
      context: context,
      builder: (_) => AppAlertDialog(
        title: title,
        message: message,
        confirmLabel: confirmLabel,
        onConfirm: onConfirm,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        AppElevatedButton(
          label: confirmLabel,
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm?.call();
          },
        ),
      ],
    );
  }
}
