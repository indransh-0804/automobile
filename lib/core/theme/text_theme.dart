import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme appTextTheme(ColorScheme colorScheme) {
  final base = GoogleFonts.interTextTheme(
    ThemeData(brightness: Brightness.dark).textTheme,
  );

  return base.copyWith(
    displayLarge: base.displayLarge?.copyWith(color: colorScheme.onSurface),
    displayMedium: base.displayMedium?.copyWith(color: colorScheme.onSurface),
    displaySmall: base.displaySmall?.copyWith(color: colorScheme.onSurface),
    headlineLarge: base.headlineLarge?.copyWith(color: colorScheme.onSurface),
    headlineMedium: base.headlineMedium?.copyWith(color: colorScheme.onSurface),
    headlineSmall: base.headlineSmall?.copyWith(color: colorScheme.onSurface),
    titleLarge: base.titleLarge?.copyWith(color: colorScheme.onSurface),
    titleMedium: base.titleMedium?.copyWith(color: colorScheme.onSurface),
    titleSmall: base.titleSmall?.copyWith(color: colorScheme.onSurface),
    bodyLarge: base.bodyLarge?.copyWith(color: colorScheme.onSurface),
    bodyMedium: base.bodyMedium?.copyWith(color: colorScheme.onSurface),
    bodySmall: base.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant),
    labelLarge: base.labelLarge?.copyWith(color: colorScheme.onSurface),
    labelMedium: base.labelMedium?.copyWith(color: colorScheme.onSurfaceVariant),
    labelSmall: base.labelSmall?.copyWith(color: colorScheme.onSurfaceVariant),
  );
}
