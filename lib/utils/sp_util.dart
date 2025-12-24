import 'package:flutter/material.dart';
import 'package:flutter_project_template/constants.dart';
import 'package:flutter_project_template/i18n/i18n.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SPUtil {
  SPUtil._internal();

  static late SharedPreferences _spf;

  static Future<SharedPreferences?> init() async {
    _spf = await SharedPreferences.getInstance();
    return _spf;
  }

  /// 首次引导
  static Future<bool> setFirst(bool first) {
    return _spf.setBool(ConstantsKeyCache.keyIsFirst, first);
  }

  static bool isFirst() {
    return _spf.getBool(ConstantsKeyCache.keyIsFirst) ?? true;
  }

  /// Locale 设置（可为 null 表示跟随系统）
  static Future<bool> setLocale(String? languageCode) {
    if (languageCode == null) {
      return _spf.remove(ConstantsKeyCache.keyLanguageCode);
    }
    return _spf.setString(ConstantsKeyCache.keyLanguageCode, languageCode);
  }

  static Locale? getLocale() {
    final String? saved = _spf.getString(ConstantsKeyCache.keyLanguageCode);
    if (saved != null && saved.isNotEmpty) return Locale(saved);

    // 跟随系统，自动匹配支持的语言
    final Locale systemLocale =
        WidgetsBinding.instance.platformDispatcher.locale;
    final String systemCode = systemLocale.languageCode;
    final bool isSupported = S.supportedLocales.any(
      (locale) => locale.languageCode == systemCode,
    );

    return isSupported ? Locale(systemCode) : null;
  }

  /// 主题模式
  static Future<bool> setThemeMode(ThemeMode mode) {
    return _spf.setString(ConstantsKeyCache.keyThemeMode, mode.name);
  }

  static ThemeMode getThemeMode() {
    final String? saved = _spf.getString(ConstantsKeyCache.keyThemeMode);
    if (saved == null) return ThemeMode.system;
    return ThemeMode.values.firstWhere(
      (m) => m.name == saved,
      orElse: () => ThemeMode.system,
    );
  }

  static Future<bool> saveAccessToken(String? token) {
    return _spf.setString(ConstantsKeyCache.keyAccessToken, token ?? '');
  }

  static String? getAccessToken() {
    return _spf.getString(ConstantsKeyCache.keyAccessToken);
  }

  static Future<bool> saveRefreshToken(String? token) {
    return _spf.setString(ConstantsKeyCache.keyRefreshToken, token ?? '');
  }

  static String? getRefreshToken() {
    return _spf.getString(ConstantsKeyCache.keyRefreshToken);
  }

  static void clean() async {
    // 清空所有本地数据，只保存是否是首次进入app的状态
    bool value = isFirst();
    await _spf.clear();
    await setFirst(value);
  }
}
