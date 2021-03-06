import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

class ToastUtil {
  static show(String msg, BuildContext context) {
    showToast(
      msg,
      position: ToastPosition.center,
      textPadding: EdgeInsets.all(20),
    );
  }
}
