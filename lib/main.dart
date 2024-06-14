import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_project_template/core/network/http.dart';
import 'package:flutter_project_template/i18n/i18n.dart';
import 'package:flutter_project_template/pages/home.dart';
import 'package:flutter_project_template/store.dart';
import 'package:flutter_project_template/theme.dart';
import 'package:flutter_project_template/utils/common_util.dart';
import 'package:flutter_project_template/utils/sp_util.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SPUtil.init().then((value) {
    XHttp.init();
    runApp(Store.init(const MyApp()));
  });
  // 安卓透明状态栏
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent));
  }
}

class MyApp extends StatefulWidget {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleStore>(
        builder: (BuildContext context, LocaleStore value, Widget? child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: MyApp.navigatorKey,
        onGenerateTitle: (context) => S.appName,
        theme: AppTheme.lightTheme(context),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          // 项目本地化资源代理
          S.delegate,
        ],
        // 支持的语言
        supportedLocales: S.supportedLocales,
        locale: Locale(value.languageCode),
        home: const HomePage(),
        builder: EasyLoading.init(
          builder: (context, child) => GestureDetector(
            onTap: () => CommonUtil.hideKeyboard(context),
            child: child,
          ),
        ),
      );
    });
  }
}
