import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  AppTheme._();

  static const _borderRadius = BorderRadius.all(Radius.circular(10));

  static ThemeData get darkTheme {
    return ThemeData.dark(useMaterial3: true).copyWith(
      brightness: Brightness.dark,
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: AppColors.primary,
        onPrimary: AppColors.onPrimary,
        primaryContainer: AppColors.primaryVariant,
        onPrimaryContainer: AppColors.onPrimary,
        secondary: AppColors.accent,
        onSecondary: AppColors.onPrimary,
        secondaryContainer: AppColors.accentVariant,
        onSecondaryContainer: AppColors.onPrimary,
        error: AppColors.error,
        onError: AppColors.onPrimary,
        surface: AppColors.surface,
        onSurface: AppColors.onSurface,
        surfaceContainerHighest: AppColors.surfaceVariant,
        outline: AppColors.inputBorder,
      ),
      scaffoldBackgroundColor: AppColors.background,
      textTheme: TextTheme(
        displayLarge: AppTextStyles.displayLarge,
        displayMedium: AppTextStyles.displayMedium,
        headlineLarge: AppTextStyles.headlineLarge,
        headlineMedium: AppTextStyles.headlineMedium,
        headlineSmall: AppTextStyles.headlineSmall,
        titleLarge: AppTextStyles.titleLarge,
        titleMedium: AppTextStyles.titleMedium,
        titleSmall: AppTextStyles.titleSmall,
        bodyLarge: AppTextStyles.bodyLarge,
        bodyMedium: AppTextStyles.bodyMedium,
        bodySmall: AppTextStyles.bodySmall,
        labelLarge: AppTextStyles.labelLarge,
        labelMedium: AppTextStyles.labelMedium,
        labelSmall: AppTextStyles.labelSmall,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.inputFill,
        border: OutlineInputBorder(
          borderRadius: _borderRadius,
          borderSide: const BorderSide(color: AppColors.inputBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: _borderRadius,
          borderSide: const BorderSide(color: AppColors.inputBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: _borderRadius,
          borderSide: const BorderSide(color: AppColors.inputBorderFocused, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: _borderRadius,
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: _borderRadius,
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        prefixIconColor: AppColors.onSurfaceMuted,
        suffixIconColor: AppColors.onSurfaceMuted,
        helperStyle: AppTextStyles.labelSmall,
        labelStyle: AppTextStyles.bodyMedium,
        hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurfaceMuted),
        errorStyle: AppTextStyles.labelSmall.copyWith(color: AppColors.error),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accent,
          foregroundColor: AppColors.onPrimary,
          disabledBackgroundColor: AppColors.accentVariant,
          disabledForegroundColor: AppColors.onSurfaceMuted,
          textStyle: AppTextStyles.labelLarge,
          shape: const RoundedRectangleBorder(borderRadius: _borderRadius),
          minimumSize: const Size(double.infinity, 52),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.onSurface,
          side: const BorderSide(color: AppColors.primary),
          textStyle: AppTextStyles.labelLarge,
          shape: const RoundedRectangleBorder(borderRadius: _borderRadius),
          minimumSize: const Size(double.infinity, 52),
        ).copyWith(
          side: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.focused)) {
              return const BorderSide(color: AppColors.accent, width: 2);
            }
            return const BorderSide(color: AppColors.primary);
          }),
        ),
      ),
      cardTheme: const CardTheme(
        color: AppColors.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: _borderRadius),
        margin: EdgeInsets.zero,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.onBackground,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: AppTextStyles.titleLarge,
        iconTheme: const IconThemeData(color: AppColors.onBackground),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.accent,
        unselectedItemColor: AppColors.onSurfaceMuted,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
        space: 1,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.primary,
        contentTextStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.onPrimary),
        behavior: SnackBarBehavior.floating,
        shape: const RoundedRectangleBorder(
          borderRadius: _borderRadius,
        ),
      ),
    );
  }
}
