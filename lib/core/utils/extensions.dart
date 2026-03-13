import 'package:flutter/material.dart';
import 'package:automobile/core/constants/app_constants.dart';

extension ContextExtensions on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  double get textScale => MediaQuery.of(this).textScaler.scale(1.0);

  double responsive(double multiplier) => kBaseUnit * multiplier;

  double get paddingSmall => responsive(1);
  double get paddingMedium => responsive(2);
  double get paddingLarge => responsive(3);
  double get paddingXLarge => responsive(4);

  double get iconSmall => responsive(2);
  double get iconMedium => responsive(3);
  double get iconLarge => responsive(4);

  double get borderRadiusSmall => responsive(0.5);
  double get borderRadiusMedium => responsive(1);
  double get borderRadiusLarge => responsive(1.5);

  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
}
