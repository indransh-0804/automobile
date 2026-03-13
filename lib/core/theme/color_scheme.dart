import 'package:flutter/material.dart';

const Color kSeedColor = Color(0xFF1A237E);

ColorScheme appColorScheme() {
  return ColorScheme.fromSeed(
    seedColor: kSeedColor,
    brightness: Brightness.dark,
  );
}
