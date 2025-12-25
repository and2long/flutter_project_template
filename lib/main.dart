import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_project_template/components/custom_loading_widget.dart';
import 'package:flutter_project_template/core/network/http.dart';
import 'package:flutter_project_template/i18n/i18n.dart';
import 'package:flutter_project_template/pages/home_page.dart';
import 'package:flutter_project_template/store.dart';
import 'package:flutter_project_template/theme.dart';
import 'package:flutter_project_template/utils/sp_util.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_ytnavigator/flutter_ytnavigator.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SPUtil.init();
  XHttp.init();
  runApp(Store.init(const MyApp()));
  // 安卓透明状态栏
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );
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
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        // 程序的字体大小不受系统字体大小影响
        textScaler: TextScaler.noScaling,
      ),
      child: Consumer<ConfigStore>(
        builder: (context, config, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: MyApp.navigatorKey,
            theme: AppTheme.lightTheme(),
            darkTheme: AppTheme.darkTheme(),
            themeMode: config.themeMode,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              S.delegate,
            ],
            supportedLocales: S.supportedLocales,
            locale: config.locale,
            home: const HomePage(),
            navigatorObservers: [YTNavigatorObserver()],
            builder: FlutterSmartDialog.init(
              builder: (context, child) => GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: child ?? const SizedBox(),
              ),
              loadingBuilder: (String msg) => CustomLoadingWidget(msg: msg),
            ),
          );
        },
      ),
    );
  }
}
