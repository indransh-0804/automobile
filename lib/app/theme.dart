import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  // ── Catppuccin Mocha palette constants ──
  static const Color mochaRosewater = Color(0xfff5e0dc);
  static const Color mochaFlamingo = Color(0xfff2cdcd);
  static const Color mochaPink = Color(0xfff5c2e7);
  static const Color mochaMauve = Color(0xffcba6f7);
  static const Color mochaRed = Color(0xfff38ba8);
  static const Color mochaMaroon = Color(0xffeba0ac);
  static const Color mochaPeach = Color(0xfffab387);
  static const Color mochaYellow = Color(0xfff9e2af);
  static const Color mochaGreen = Color(0xffa6e3a1);
  static const Color mochaTeal = Color(0xff94e2d5);
  static const Color mochaSky = Color(0xff89dceb);
  static const Color mochaSapphire = Color(0xff74c7ec);
  static const Color mochaBlue = Color(0xff89b4fa);
  static const Color mochaLavender = Color(0xffb4befe);

  static const Color mochaText = Color(0xffcdd6f4);
  static const Color mochaSubtext1 = Color(0xffbac2de);
  static const Color mochaSubtext0 = Color(0xffa6adc8);
  static const Color mochaOverlay2 = Color(0xff9399b2);
  static const Color mochaOverlay1 = Color(0xff7f849c);
  static const Color mochaOverlay0 = Color(0xff6c7086);
  static const Color mochaSurface2 = Color(0xff585b70);
  static const Color mochaSurface1 = Color(0xff45475a);
  static const Color mochaSurface0 = Color(0xff313244);
  static const Color mochaBase = Color(0xff1e1e2e);
  static const Color mochaMantle = Color(0xff181825);
  static const Color mochaCrust = Color(0xff11111b);

  // ── Light scheme (Catppuccin Latte, Blue primary) ──
  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff1e66f5),
      surfaceTint: Color(0xff1e66f5),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffdce4ff),
      onPrimaryContainer: Color(0xff14408f),
      secondary: Color(0xff7287fd),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffdde2ff),
      onSecondaryContainer: Color(0xff3a4a9e),
      tertiary: Color(0xff8839ef),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffe8deff),
      onTertiaryContainer: Color(0xff5c2d91),
      error: Color(0xffd20f39),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xffeff1f5),
      onSurface: Color(0xff4c4f69),
      onSurfaceVariant: Color(0xff6c6f85),
      outline: Color(0xff8c8fa1),
      outlineVariant: Color(0xffbcc0cc),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: mochaSurface0,
      inversePrimary: mochaBlue,
      primaryFixed: Color(0xffdce4ff),
      onPrimaryFixed: Color(0xff0a2d6e),
      primaryFixedDim: Color(0xffaac4fc),
      onPrimaryFixedVariant: Color(0xff14408f),
      secondaryFixed: Color(0xffdde2ff),
      onSecondaryFixed: Color(0xff1a2565),
      secondaryFixedDim: Color(0xffaab4f0),
      onSecondaryFixedVariant: Color(0xff3a4a9e),
      tertiaryFixed: Color(0xffe8deff),
      onTertiaryFixed: Color(0xff3b1272),
      tertiaryFixedDim: Color(0xffc9a9f5),
      onTertiaryFixedVariant: Color(0xff5c2d91),
      surfaceDim: Color(0xffdce0e8),
      surfaceBright: Color(0xffeff1f5),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffe6e9ef),
      surfaceContainer: Color(0xffdce0e8),
      surfaceContainerHigh: Color(0xffccd0da),
      surfaceContainerHighest: Color(0xffbcc0cc),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  // ── Dark scheme (Catppuccin Mocha, Blue primary, Mantle surface) ──
  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: mochaBlue,
      surfaceTint: mochaBlue,
      onPrimary: mochaCrust,
      primaryContainer: Color(0xff14408f),
      onPrimaryContainer: Color(0xffdce4ff),
      secondary: mochaLavender,
      onSecondary: mochaCrust,
      secondaryContainer: mochaSurface1,
      onSecondaryContainer: mochaText,
      tertiary: mochaMauve,
      onTertiary: mochaCrust,
      tertiaryContainer: Color(0xff5c2d91),
      onTertiaryContainer: Color(0xffe8deff),
      error: mochaRed,
      onError: mochaCrust,
      errorContainer: mochaMaroon,
      onErrorContainer: mochaCrust,
      surface: mochaMantle,
      onSurface: mochaText,
      onSurfaceVariant: mochaSubtext0,
      outline: mochaOverlay0,
      outlineVariant: mochaSurface1,
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: mochaText,
      inversePrimary: Color(0xff1e66f5),
      primaryFixed: Color(0xffdce4ff),
      onPrimaryFixed: Color(0xff0a2d6e),
      primaryFixedDim: mochaBlue,
      onPrimaryFixedVariant: Color(0xff14408f),
      secondaryFixed: Color(0xffdde2ff),
      onSecondaryFixed: Color(0xff1a2565),
      secondaryFixedDim: mochaLavender,
      onSecondaryFixedVariant: Color(0xff3a4a9e),
      tertiaryFixed: Color(0xffe8deff),
      onTertiaryFixed: Color(0xff3b1272),
      tertiaryFixedDim: mochaMauve,
      onTertiaryFixedVariant: Color(0xff5c2d91),
      surfaceDim: mochaCrust,
      surfaceBright: mochaSurface1,
      surfaceContainerLowest: mochaCrust,
      surfaceContainerLow: mochaMantle,
      surfaceContainer: mochaBase,
      surfaceContainerHigh: mochaSurface0,
      surfaceContainerHighest: mochaSurface1,
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.surface,
        canvasColor: colorScheme.surface,
      );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light, dark;
  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.dark,
  });
}

class ColorFamily {
  final Color color, onColor, colorContainer, onColorContainer;
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });
}