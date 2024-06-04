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

  /// 语言
  static Future<bool> setLanguageCode(String languageCode) {
    return _spf.setString(ConstantsKeyCache.keyLanguageCode, languageCode);
  }

  static String getLanguageCode() {
    return _spf.getString(ConstantsKeyCache.keyLanguageCode) ??
        S.supportedLocales.first.languageCode;
  }

  static Future<bool> saveAccessToken(String? token) {
    return _spf.setString(ConstantsKeyCache.keyAccessToken, token ?? '');
  }

  static String? getAccessToken() {
    return _spf.getString(ConstantsKeyCache.keyAccessToken);
  }

  static Future<bool> saveTokenType(String? value) {
    return _spf.setString(ConstantsKeyCache.keyTokenType, value ?? '');
  }

  static String getTokenType() {
    return _spf.getString(ConstantsKeyCache.keyTokenType) ?? '';
  }

  static Future<bool> saveRefreshToken(String? token) {
    return _spf.setString(ConstantsKeyCache.keyRefreshToken, token ?? '');
  }

  static String? getRefreshToken() {
    return _spf.getString(ConstantsKeyCache.keyRefreshToken);
  }

  static void clean() async {
    // 清空所有本地数据，只保存是否是首次进入app的状态和语言设置
    bool value = isFirst();
    String languageCode = getLanguageCode();
    await _spf.clear();
    await setFirst(value);
    await setLanguageCode(languageCode);
  }
}
