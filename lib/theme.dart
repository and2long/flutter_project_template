import 'package:flutter/material.dart';

/// | NAME           | SIZE |  WEIGHT |  SPACING |             |
/// |----------------|------|---------|----------|-------------|
/// | displayLarge   | 96.0 | light   | -1.5     |             |
/// | displayMedium  | 60.0 | light   | -0.5     |             |
/// | displaySmall   | 48.0 | regular |  0.0     |             |
/// | headlineMedium | 34.0 | regular |  0.25    |             |
/// | headlineSmall  | 24.0 | regular |  0.0     |             |
/// | titleLarge     | 20.0 | medium  |  0.15    |             |
/// | titleMedium    | 16.0 | regular |  0.15    |             |
/// | titleSmall     | 14.0 | medium  |  0.1     |             |
/// | bodyLarge      | 16.0 | regular |  0.5     |             |
/// | bodyMedium     | 14.0 | regular |  0.25    |             |
/// | bodySmall      | 12.0 | regular |  0.4     |             |
/// | labelLarge     | 14.0 | medium  |  1.25    |             |
/// | labelSmall     | 10.0 | regular |  1.5     |             |
///
/// ...where "light" is `FontWeight.w300`, "regular" is `FontWeight.w400` and
/// "medium" is `FontWeight.w500`.

const themeColor = Colors.blue;
const dividerColor = Color(0xFFE8E8E8);
const backgroundColor = Color(0xfff8f8f8);

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: themeColor,
        dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
      ),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      dividerTheme: DividerThemeData(color: Colors.grey[300], space: 1),
      brightness: Brightness.light,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 1.0,
        color: Colors.grey[50],
        titleTextStyle: const TextStyle(
          fontSize: 18,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          shape: const StadiumBorder(),
          elevation: 0,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.all(13),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: const StadiumBorder(),
          elevation: 0,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.all(13),
        ),
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          fontSize: 18,
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: Colors.black,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          color: Colors.black38,
        ),
      ),
    );
  }
}
