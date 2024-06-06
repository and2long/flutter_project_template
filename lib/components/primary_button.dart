import 'package:flutter/material.dart';
import 'package:flutter_project_template/theme.dart';

/// 通用的按钮
class PrimaryButton extends StatelessWidget {
  final String text;
  final Color? bgColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onPressed;

  const PrimaryButton({
    super.key,
    required this.text,
    this.textColor,
    this.bgColor,
    this.width,
    this.height,
    this.margin,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height ?? 60,
      width: width,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              WidgetStateProperty.all<Color>(bgColor ?? themeColor),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
              EdgeInsets.symmetric(vertical: 0, horizontal: 30)),
        ),
        onPressed: onPressed,
        child: Text(
          textAlign: TextAlign.center,
          text,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: textColor ?? Colors.white),
        ),
      ),
    );
  }
}
