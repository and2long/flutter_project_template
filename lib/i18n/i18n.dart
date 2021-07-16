import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_template/i18n/i18n_en.dart';
import 'package:flutter_project_template/i18n/i18n_ja.dart';
import 'package:flutter_project_template/i18n/i18n_zh.dart';

class SLocalizationsDelegate extends LocalizationsDelegate<S> {
  const SLocalizationsDelegate();

  static const SLocalizationsDelegate delegate = const SLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<S> load(Locale locale) {
    S.locale = locale;
    return SynchronousFuture<S>(S());
  }

  @override
  bool shouldReload(SLocalizationsDelegate old) => false;
}

class S {
  const S();

  static Locale? _locale;

  static set locale(Locale newLocale) {
    S._locale = newLocale;
  }

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S)!;
  }

  static List<Locale> get supportedLocales {
    return const <Locale>[Locale("en"), Locale("ja"), Locale("zh")];
  }

  Object getItem(String key) {
    Map localData;
    switch (_locale?.languageCode ?? '') {
      case 'en':
        localData = I18N_EN;
        break;
      case 'ja':
        localData = I18N_JA;
        break;
      case 'zh':
        localData = I18N_ZH;
        break;
      default:
        localData = I18N_EN;
        break;
    }
    return localData[key];
  }

  String get appName => getItem('app_name') as String;

  /// common
  String get delete => getItem('delete') as String;
  String get edit => getItem('edit') as String;
  String get cancel => getItem('cancel') as String;
  String get ok => getItem('ok') as String;
  String get publish => getItem('publish') as String;
  String get save => getItem('save') as String;
  String get send => getItem('send') as String;
  String get search => getItem('search') as String;
  String get skip => getItem('skip') as String;
  String get next => getItem('next') as String;
  String get start => getItem('start') as String;
  String get readAndAgree => getItem('read_and_agree') as String;
  String get privacyPolicy => getItem('privacy_policy') as String;
  String get termsOfService => getItem('terms_of_service') as String;
  String get collapse => getItem('collapse') as String;
  String get expand => getItem('expand') as String;
  String get english => 'English';
  String get japanese => '日本語';
  String get simpleChinese => '简体中文';
  Map<String, String> get localeSets =>
      {'en': english, 'ja': japanese, 'zh': simpleChinese};
  String get date => getItem('date') as String;
  String get time => getItem('time') as String;


}
