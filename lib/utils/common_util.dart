import 'package:flutter/material.dart';

class CommonUtil {
  CommonUtil._internal();

  /// 判断登录密码：6~16位数字和字符组合
  static bool isLoginPassword(String input) {
    RegExp mobile = RegExp(r"(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$");
    return mobile.hasMatch(input);
  }

  /// 6位数字验证码
  static bool isValidateCaptcha(String input) {
    RegExp mobile = RegExp(r"\d{6}$");
    return mobile.hasMatch(input);
  }

  /// 邮箱匹配
  static bool matchEmail(String email) {
    var re =
        "[\\w!#\$%&'*+/=?^_`{|}~-]+(?:\\.[\\w!#\$%&'*+/=?^_`{|}~-]+)*@(?:[\\w](?:[\\w-]*[\\w])?\\.)+[\\w](?:[\\w-]*[\\w])?";
    return RegExp(re).hasMatch(email);
  }

  /// 隐藏键盘
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  /// 限制组件在大屏下的显示宽度。
  static Widget generateWidgetOfWideScreen(Widget child, {double? maxWidth}) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 600) {
          return Center(
            child: SizedBox(width: maxWidth ?? 600, child: child),
          );
        } else {
          return child;
        }
      },
    );
  }

  static String? extractCacheKey(String? url) {
    if (url == null || url.isEmpty) {
      return null;
    }

    try {
      final uri = Uri.parse(url);
      if (uri.pathSegments.isEmpty) {
        return null;
      }
      return uri.pathSegments.last;
    } catch (_) {
      return null;
    }
  }
}
