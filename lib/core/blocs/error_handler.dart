import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_ytlog/flutter_ytlog.dart';

const String _tag = 'ErrorHandler';

void handleError(Object e, {StackTrace? stackTrace}) {
  Log.e(_tag, e);
  Log.e(_tag, stackTrace);
  // TODO 全局错误处理
  SmartDialog.showToast(e.toString());
}
