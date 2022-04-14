import 'package:flutter/foundation.dart';

class Log {
  static void d(String tag, Object? content) {
    if (kDebugMode || kProfileMode) {
      // ignore: avoid_print
      print('$tag : $content');
    }
  }

  static void i(Object? object) {
    if (kDebugMode || kProfileMode) {
      // ignore: avoid_print
      print(object);
    }
  }
}
