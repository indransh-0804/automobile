import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

enum AMSnackbarType { success, error, notification }

void showAMSnackbar(
  BuildContext context, {
  required String message,
  required AMSnackbarType type,
}) {
  final Color backgroundColor;
  final IconData iconData;

  switch (type) {
    case AMSnackbarType.success:
      backgroundColor = AppColors.success;
      iconData = Icons.check_circle_outline;
    case AMSnackbarType.error:
      backgroundColor = AppColors.error;
      iconData = Icons.error_outline;
    case AMSnackbarType.notification:
      backgroundColor = AppColors.primary;
      iconData = Icons.notifications_none;
  }

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      content: Row(
        children: [
          Icon(iconData, color: AppColors.onPrimary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onPrimary),
            ),
          ),
        ],
      ),
    ),
  );
}
