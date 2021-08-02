import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

class ToastUtil {
  static show(String msg) {
    showToast(
      msg,
      position: ToastPosition.center,
      textPadding: EdgeInsets.all(20),
      duration: Duration(seconds: 3),
    );
  }
}
