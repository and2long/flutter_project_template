import 'package:flutter/material.dart';

import 'log_util.dart';

class NavigatorUtil {
  static const String _tag = 'NavigatorUtil';

  static Future push(BuildContext context, Widget widget) {
    Log.i(_tag, widget.runtimeType.toString());
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
        settings: RouteSettings(name: widget.runtimeType.toString()),
      ),
    );
  }

  static Future pushReplacement(BuildContext context, Widget widget) {
    Log.i(_tag, widget.runtimeType.toString());
    return Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
        settings: RouteSettings(name: widget.runtimeType.toString()),
      ),
    );
  }
}
