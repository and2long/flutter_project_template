import 'package:flutter/foundation.dart';

class Log {
  static void d(String tag, Object content) {
    if (kDebugMode || kProfileMode) {
      print('$tag : $content');
    }
  }

  static void i(Object object) {
    if (kDebugMode || kProfileMode) {
      print(object);
    }
  }
}
