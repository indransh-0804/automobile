import 'package:automobile/app/theme.dart';
import 'package:flutter/material.dart';

/// Semantic helpers for places where Theme.of(context) is unavailable
/// (gradients in providers, CustomPainter, etc).
class AppColors {
  AppColors._();

  static const Color success = MaterialTheme.mochaGreen;
  static const Color error = MaterialTheme.mochaRed;
  static const Color warning = MaterialTheme.mochaYellow;
  static const Color info = MaterialTheme.mochaSapphire;
  static const Color peach = MaterialTheme.mochaPeach;
  static const Color maroon = MaterialTheme.mochaMaroon;
  static const Color mauve = MaterialTheme.mochaMauve;

  // Card gradient pairs (dark mode only — used in KPI cards)
  static const List<Color> revenueGradient = [Color(0xFF1E2A48), Color(0xFF1E1E2E)];
  static const List<Color> salesGradient = [Color(0xFF222840), Color(0xFF1E1E2E)];
  static const List<Color> loansGradient = [Color(0xFF28203C), Color(0xFF1E1E2E)];
  static const List<Color> testDriveGradient = [Color(0xFF1C2C34), Color(0xFF1E1E2E)];
}