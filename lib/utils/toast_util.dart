import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

class ToastUtil {
  static show(String msg) {
    showToast(
      msg,
      position: ToastPosition.center,
      textPadding: const EdgeInsets.all(20),
      duration: const Duration(seconds: 3),
    );
  }
}
