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
class AppTheme {
  AppTheme._();

  static ThemeData mainTheme(BuildContext context) {
    return ThemeData(
      // 涟漪颜色
      splashColor: Colors.transparent,
      // 按下阴影颜色
      highlightColor: Colors.grey[200],
      dividerTheme: DividerThemeData(color: Colors.grey[300], space: 1),
      appBarTheme: AppBarTheme(
        brightness: Brightness.light,
        color: Colors.grey[50],
        centerTitle: true,
        actionsIconTheme: IconThemeData(color: Colors.black87),
        iconTheme: IconThemeData(color: Colors.black87),
        elevation: 1.0,
      ),
      primaryTextTheme: TextTheme(headline6: TextStyle(color: Colors.black87)),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
