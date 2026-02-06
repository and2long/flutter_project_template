import 'package:flutter/material.dart';
import 'package:flutter_project_template/utils/sp_util.dart';

/// 全局配置
class ConfigStore with ChangeNotifier {
  Locale _locale;
  ThemeMode _themeMode;

  ConfigStore({required Locale locale, ThemeMode themeMode = ThemeMode.system})
    : _locale = locale,
      _themeMode = themeMode;

  Locale get locale => _locale;
  ThemeMode get themeMode => _themeMode;

  void setLocale(Locale locale) {
    if (_locale.toLanguageTag() == locale.toLanguageTag()) return;
    _locale = locale;
    SPUtil.setLocale(locale.languageCode);
    notifyListeners();
  }

  void setThemeMode(ThemeMode mode) {
    if (_themeMode == mode) return;
    _themeMode = mode;
    SPUtil.setThemeMode(mode);
    notifyListeners();
  }
}
