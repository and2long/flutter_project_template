import 'dart:developer';

import 'package:flutter/foundation.dart';

class Log {
  Log._();

  static void d(String tag, Object? content) {
    if (kDebugMode || kProfileMode) {
      mPrint(LogLevel.DEBUG, tag, content.toString());
    }
  }

  static void i(String tag, Object? content) {
    if (kDebugMode || kProfileMode) {
      mPrint(LogLevel.INFO, tag, content.toString());
    }
  }

  static void w(String tag, Object? content) {
    if (kDebugMode || kProfileMode) {
      mPrint(LogLevel.WARNING, tag, content.toString());
    }
  }

  static void e(String tag, Object? content) {
    if (kDebugMode || kProfileMode) {
      mPrint(LogLevel.ERROR, tag, content.toString());
    }
  }

  static void mPrint(
    LogLevel level,
    String tag,
    String content, {
    bool showDatetime = false,
  }) {
    // 终端颜色：https://zhuanlan.zhihu.com/p/634706318
    var start = '\x1b[90m';
    const end = '\x1b[0m';

    const white = '\x1b[37m';
    const red = '\x1B[31m';
    const green = '\x1B[32m';
    const yellow = '\x1B[33m';
    const blue = '\x1B[34m';

    switch (level) {
      case LogLevel.DEBUG:
        start = blue;
        break;
      case LogLevel.INFO:
        start = green;
        break;
      case LogLevel.WARNING:
        start = yellow;
        break;
      case LogLevel.ERROR:
        start = red;
    }
    String datetimeStr = showDatetime ? '$white${DateTime.now()} ' : '';
    final message = '$start$datetimeStr[$tag] [${level.name}] : $content$end';
    log(message);
  }
}

// ignore: constant_identifier_names
enum LogLevel { DEBUG, INFO, WARNING, ERROR }
