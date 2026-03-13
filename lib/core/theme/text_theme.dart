import 'package:flutter/material.dart';

TextTheme appTextTheme(BuildContext context) {
  final scaler = MediaQuery.textScalerOf(context);
  return TextTheme(
    displayLarge: TextStyle(fontSize: scaler.scale(57)),
    displayMedium: TextStyle(fontSize: scaler.scale(45)),
    displaySmall: TextStyle(fontSize: scaler.scale(36)),
    headlineLarge: TextStyle(fontSize: scaler.scale(32)),
    headlineMedium: TextStyle(fontSize: scaler.scale(28)),
    headlineSmall: TextStyle(fontSize: scaler.scale(24)),
    titleLarge: TextStyle(fontSize: scaler.scale(22)),
    titleMedium: TextStyle(
      fontSize: scaler.scale(16),
      fontWeight: FontWeight.w500,
    ),
    titleSmall: TextStyle(
      fontSize: scaler.scale(14),
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: TextStyle(fontSize: scaler.scale(16)),
    bodyMedium: TextStyle(fontSize: scaler.scale(14)),
    bodySmall: TextStyle(fontSize: scaler.scale(12)),
    labelLarge: TextStyle(
      fontSize: scaler.scale(14),
      fontWeight: FontWeight.w500,
    ),
    labelMedium: TextStyle(
      fontSize: scaler.scale(12),
      fontWeight: FontWeight.w500,
    ),
    labelSmall: TextStyle(
      fontSize: scaler.scale(11),
      fontWeight: FontWeight.w500,
    ),
  );
}
