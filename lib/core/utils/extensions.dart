import 'package:flutter/material.dart';
import 'package:automobile/core/constants/app_constants.dart';
import 'package:intl/intl.dart';

extension ResponsiveExtension on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;

  double responsive(double multiplier) => kBaseUnit * multiplier;

  double get paddingSmall => responsive(1);
  double get paddingMedium => responsive(2);
  double get paddingLarge => responsive(3);
  double get paddingXLarge => responsive(4);

  double get iconSmall => responsive(2.5);
  double get iconMedium => responsive(3);
  double get iconLarge => responsive(4);

  double get radiusSmall => responsive(1);
  double get radiusMedium => responsive(1.5);
  double get radiusLarge => responsive(2);

  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension DateTimeFormatting on DateTime {
  String get formattedDate => DateFormat.yMMMd().format(this);
  String get formattedDateTime => DateFormat.yMMMd().add_jm().format(this);
  String get formattedTime => DateFormat.jm().format(this);

  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }
}
