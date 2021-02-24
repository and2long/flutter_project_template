import 'package:shared_preferences/shared_preferences.dart';

class SPUtils {
  SPUtils._internal();

  static SharedPreferences _spf;

  static Future<SharedPreferences> init() async {
    if (_spf == null) {
      _spf = await SharedPreferences.getInstance();
    }
    return _spf;
  }

  /// 语言
  static Future<bool> setLanguageCode(String languageCode) {
    return _spf.setString('language_code', languageCode);
  }

  static String getLanguageCode() {
    return _spf.getString('language_code');
  }

  /// 首次引导
  static Future<bool> setFirst(bool first) {
    return _spf.setBool('first', first);
  }

  static bool isFirst() {
    return _spf.getBool('first') ?? true;
  }
}
