import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class ToastUtil {
  static show(String msg, BuildContext context) {
    Toast.show(msg, context,
        duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
  }
}
