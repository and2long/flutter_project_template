import 'package:flutter/material.dart';

// NAME         SIZE  WEIGHT  SPACING
// headline1    96.0  light   -1.5
// headline2    60.0  light   -0.5
// headline3    48.0  regular  0.0
// headline4    34.0  regular  0.25
// headline5    24.0  regular  0.0
// headline6    20.0  medium   0.15
// subtitle1    16.0  regular  0.15
// subtitle2    14.0  medium   0.1
// body1        16.0  regular  0.5   (bodyText1)
// body2        14.0  regular  0.25  (bodyText2) (default)
// button       14.0  medium   1.25
// caption      12.0  regular  0.4

const titleSize = 18.0;

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      // 涟漪颜色
      splashColor: Colors.transparent,
      dividerTheme: DividerThemeData(color: Colors.grey[300], space: 1),
      brightness: Brightness.light,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 1.0,
        color: Colors.grey[50],
        iconTheme: const IconThemeData(color: Colors.black87),
        titleTextStyle: const TextStyle(
          fontSize: titleSize,
          color: Colors.black87,
        ),
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
    );
  }

  static ThemeData darkTheme(BuildContext context) {
    return ThemeData(
      // 涟漪颜色
      splashColor: Colors.transparent,
      dividerTheme: DividerThemeData(color: Colors.grey[300], space: 1),
      brightness: Brightness.dark,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 1.0,
        color: Colors.grey[850],
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
          fontSize: titleSize,
          color: Colors.black87,
        ),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          shape: const StadiumBorder(),
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
      ),
    );
  }
}
