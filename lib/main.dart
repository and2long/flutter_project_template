import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_project_template/i18n/i18n.dart';
import 'package:flutter_project_template/init/provider.dart';
import 'package:flutter_project_template/init/route_map.dart';
import 'package:flutter_project_template/init/theme.dart';
import 'package:flutter_project_template/network/http.dart';
import 'package:flutter_project_template/pages/home.dart';
import 'package:flutter_project_template/utils/common_util.dart';
import 'package:flutter_project_template/utils/sp_utils.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SPUtils.init().then((value) {
    XHttp.init();
    runApp(Store.init(const MyApp()));
  });
  // 安卓透明状态栏
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleStore>(builder: (context, localeStore, _) {
      return OKToast(
        movingOnWindowChange: false,
        child: MaterialApp(
          onGenerateTitle: (context) => S.appName,
          theme: AppTheme.lightTheme(context),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            // 项目本地化资源代理
            S.delegate,
          ],
          // 支持的语言
          supportedLocales: S.supportedLocales,
          // 指定语言，如果 localStore 里没有保存的语言参数，则直接使用 S 文件中配置的第一个语言。
          locale: localeStore.languageCode == null
              ? S.supportedLocales.first
              : Locale(localeStore.languageCode!),
          routes: RouteMap.routes,
          home: const HomePage(),
          builder: (context, child) => GestureDetector(
            onTap: () => CommonUtils.hideKeyboard(context),
            child: child,
          ),
        ),
      );
    });
  }
}
