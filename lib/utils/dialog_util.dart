import 'package:flutter/material.dart';
import 'package:flutter_project_template/i18n/i18n.dart';
import 'package:flutter_project_template/main.dart';
import 'package:flutter_project_template/theme.dart';
import 'package:flutter_ytlog/log.dart';

class DialogUtil {
  static const String _tag = 'DialogUtil';
  DialogUtil._internal();

  static final _shape =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10));

  static Widget _buildDialogContent(String content) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: Text(
        content,
        textAlign: TextAlign.center,
      ),
    );
  }

  /// 显示提示框：内容+取消按钮+确定按钮，确定按钮需要点击事件。
  static _showAlertDialog2(
      BuildContext context, String content, VoidCallback onPressed) {
    TextStyle textStyle =
        Theme.of(context).textTheme.bodyMedium!.copyWith(color: themeColor);

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: _shape,
          content: _buildDialogContent(content),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    S.of(context).dialogBtnClose,
                    style: textStyle.copyWith(color: Colors.grey),
                  ),
                ),
                TextButton(
                  onPressed: onPressed,
                  child: Text(
                    S.of(context).dialogBtnConfirm,
                    style: textStyle,
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  /// 显示提示框：内容+关闭按钮
  static _showAlertDialog(BuildContext context, String content,
      {VoidCallback? onPressed}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: _shape,
          content: _buildDialogContent(content),
          actions: [
            Center(
              child: TextButton(
                onPressed: onPressed ?? () => Navigator.pop(context),
                child: Text(
                  S.of(context).dialogBtnClose,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: themeColor),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  /// 显示自定义提示框
  static showCustomDialog(BuildContext context, Widget child) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: _shape,
          content: child,
        );
      },
    );
  }

  static void showAlertDialog(String content) {
    if (MyApp.navigatorKey.currentContext != null) {
      _showAlertDialog(MyApp.navigatorKey.currentContext!, content);
    } else {
      Log.e(_tag, 'global key is null');
    }
  }

  static void showAlertDialog2({
    required String content,
    required VoidCallback onPositiveBtnPressed,
  }) {
    BuildContext? context = MyApp.navigatorKey.currentContext;
    if (context != null) {
      _showAlertDialog2(
        context,
        content,
        () => onPositiveBtnPressed(),
      );
    } else {
      Log.e(_tag, 'global key is null');
    }
  }
}
