import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class ToastUtil {
  ToastUtil._();

  static void show(String? msg) {
    if (msg != null && msg.isNotEmpty) {
      SmartDialog.showToast(msg);
    }
  }
}
