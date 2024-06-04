import 'package:fluttertoast/fluttertoast.dart';

// Toast with No Build Context (Android & iOS)
// https://pub-web.flutter-io.cn/packages/fluttertoast#toast-with-no-build-context-android--ios
class ToastUtil {
  ToastUtil._();
  static show(String? msg) {
    Fluttertoast.showToast(
      msg: msg ?? '',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
    );
  }
}
