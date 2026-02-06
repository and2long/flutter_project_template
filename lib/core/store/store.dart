import 'package:flutter/material.dart';
import 'package:flutter_project_template/core/store/config_store.dart';
import 'package:flutter_project_template/utils/sp_util.dart';
import 'package:provider/provider.dart';

/// 全局状态管理
class Store {
  Store._internal();

  // 初始化
  static MultiProvider init(Widget child) {
    return MultiProvider(
      providers: [
        // 配置中心 (语言 + 主题)
        ChangeNotifierProvider(
          create: (_) => ConfigStore(
            locale: SPUtil.getLocale(),
            themeMode: SPUtil.getThemeMode(),
          ),
        ),
      ],
      child: child,
    );
  }
}
