import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../buttons/am_elevated_button.dart';
import '../buttons/am_outline_button.dart';

void showAMAlertDialog(
  BuildContext context, {
  required String title,
  required String message,
  String confirmLabel = 'Confirm',
  String cancelLabel = 'Cancel',
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
  bool isDangerous = false,
}) {
  showDialog<void>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      backgroundColor: AppColors.surface,
      title: Text(
        title,
        style: AppTextStyles.titleLarge.copyWith(color: AppColors.onSurface),
      ),
      content: Text(
        message,
        style: AppTextStyles.bodyMedium,
      ),
      actionsAlignment: MainAxisAlignment.end,
      actions: [
        Row(
          children: [
            Expanded(
              child: AMOutlineButton(
                label: cancelLabel,
                onPressed: onCancel ?? () => Navigator.of(dialogContext).pop(),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: AMElevatedButton(
                label: confirmLabel,
                onPressed: onConfirm,
                backgroundColor: isDangerous ? AppColors.error : null,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
