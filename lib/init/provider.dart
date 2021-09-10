import 'package:flutter/material.dart';
import 'package:flutter_project_template/utils/sp_utils.dart';
import 'package:provider/provider.dart';

/// 全局状态管理
class Store {
  Store._internal();

  // 初始化
  static init(Widget child) {
    return MultiProvider(
      providers: [
        // 国际化
        ChangeNotifierProvider.value(
            value: LocaleStore(SPUtils.getLanguageCode())),
      ],
      child: child,
    );
  }
}

/// 语言
class LocaleStore with ChangeNotifier {
  String? _languageCode;

  LocaleStore(this._languageCode);

  String? get languageCode => _languageCode;

  set languageCode(String? languageCode) {
    if (languageCode != null && languageCode != _languageCode) {
      _languageCode = languageCode;
      SPUtils.setLanguageCode(languageCode);
      notifyListeners();
    }
  }

  void setLanguageCode(String? languageCode) {
    if (languageCode != null) {
      _languageCode = languageCode;
      SPUtils.setLanguageCode(languageCode);
    }
  }
}
