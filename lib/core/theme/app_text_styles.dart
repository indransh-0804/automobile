import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle get displayLarge => GoogleFonts.inter(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        color: AppColors.onBackground,
      );

  static TextStyle get displayMedium => GoogleFonts.inter(
        fontSize: 45,
        fontWeight: FontWeight.w400,
        color: AppColors.onBackground,
      );

  static TextStyle get headlineLarge => GoogleFonts.inter(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: AppColors.onBackground,
      );

  static TextStyle get headlineMedium => GoogleFonts.inter(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: AppColors.onBackground,
      );

  static TextStyle get headlineSmall => GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.onBackground,
      );

  static TextStyle get titleLarge => GoogleFonts.inter(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: AppColors.onBackground,
      );

  static TextStyle get titleMedium => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.onBackground,
      );

  static TextStyle get titleSmall => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.onBackground,
      );

  static TextStyle get bodyLarge => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.onBackground,
      );

  static TextStyle get bodyMedium => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.onBackground,
      );

  static TextStyle get bodySmall => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.onBackground,
      );

  static TextStyle get labelLarge => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.onSurface,
      );

  static TextStyle get labelMedium => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.onSurface,
      );

  static TextStyle get labelSmall => GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: AppColors.onSurface,
      );
}
