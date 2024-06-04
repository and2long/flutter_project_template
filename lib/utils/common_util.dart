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
}
