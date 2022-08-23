import 'package:flutter/material.dart';
import 'package:flutter_project_template/components/loading_indicator.dart';
import 'package:flutter_project_template/i18n/i18n.dart';

class DialogUtils {
  /// 显示提示框：提示文本+确定按钮。
  static showAlertDialog(BuildContext context, String content,
      {VoidCallback? onPressed}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: onPressed ?? () => Navigator.of(context).pop(),
              child: Text(S.of(context).ok,
                  style: TextStyle(color: Theme.of(context).primaryColor)),
            )
          ],
        );
      },
    );
  }

  /// 显示提示框：内容+取消按钮+确定按钮，确定按钮需要点击事件。
  static Future<bool?> showAlertDialog2Actions(
      BuildContext context, String content, VoidCallback onPressed) async {
    return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(content),
          actions: <Widget>[
            TextButton(
                child: Text(S.of(context).cancel,
                    style: TextStyle(color: Theme.of(context).primaryColor)),
                onPressed: () {
                  Navigator.pop(context, false);
                }),
            TextButton(
                onPressed: onPressed,
                child: Text(S.of(context).ok,
                    style: TextStyle(color: Theme.of(context).primaryColor))),
          ],
        );
      },
    );
  }

  /// 显示等待框
  static showWaitDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        barrierColor: Colors.black26,
        builder: (context) {
          return Center(
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular((10.0)),
                color: Colors.grey[300],
              ),
              child: const LoadingIndicator(),
            ),
          );
        });
  }
}
