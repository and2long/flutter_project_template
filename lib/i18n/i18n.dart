import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_template/i18n/i18n_ja.dart';
import 'package:flutter_project_template/i18n/i18n_zh.dart';

/// 项目本地化资源代理
class ProjectLocalizationsDelegate extends LocalizationsDelegate<S> {
  const ProjectLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<S> load(Locale locale) {
    return SynchronousFuture<S>(getMaterialTranslation(locale));
  }

  @override
  bool shouldReload(ProjectLocalizationsDelegate old) => false;

  /// 根据 locale 得到对应的本地化资源
  S getMaterialTranslation(Locale locale) {
    switch (locale.languageCode) {
      case 'zh':
        return ProjectLocalizationsZH();
      case 'ja':
        return ProjectLocalizationsJA();
      default:
        return ProjectLocalizationsJA();
    }
  }
}

/// 本地化资源 基类
abstract class S {
  /// 本地化资源代理对象
  static const LocalizationsDelegate delegate = ProjectLocalizationsDelegate();

  /// 根据上下文中的 [Locale] 取得对应的本地化资源。
  static S of(BuildContext context) {
    return Localizations.of<S>(context, S)!;
  }

  /// 支持的语言。
  /// 如果本地没有保存的语言配置参数，APP会默认使用第一个作为默认语言。
  static List<Locale> supportedLocales = [
    const Locale('en'),
    const Locale('ja'),
    const Locale('zh')
  ];

  // 不需要翻译的字段，直接赋值。
  static String appName = 'AppName';
  static String japanese = '日本語';
  static String simpleChinese = '简体中文';
  static Map<String, String> localeSets = {'ja': japanese, 'zh': simpleChinese};

  // 需要翻译的字段追加到下面，在子类中进行赋值。
  String get cancel;
  String get ok;
  String get readAndAgree;
  String get privacyPolicy;
  String get termsOfService;

  String get me;
  String get settingsLanguage;

  String get dialogBtnClose;
  String get dialogBtnConfirm;
}
