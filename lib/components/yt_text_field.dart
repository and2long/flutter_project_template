import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project_template/theme.dart';

class YTTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final int? maxLines;
  final int? maxLength;
  final EdgeInsetsGeometry? margin;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final ValueChanged<String>? onSubmitted;
  final bool obscureText;
  const YTTextField({
    super.key,
    required this.controller,
    this.maxLines,
    this.maxLength,
    this.hintText,
    this.textInputAction,
    this.margin,
    this.keyboardType,
    this.inputFormatters,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.onSubmitted,
  });

  @override
  State<YTTextField> createState() => _YTTextFieldState();
}

class _YTTextFieldState extends State<YTTextField> {
  bool _showSufix = false;
  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: const BorderSide(
        color: dividerColor,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(10),
    );
    return Container(
      margin: widget.margin,
      child: TextField(
        maxLength: widget.maxLength,
        obscureText: widget.obscureText,
        inputFormatters: widget.inputFormatters,
        keyboardType: widget.keyboardType,
        autocorrect: false,
        textInputAction: widget.textInputAction ??
            ((widget.maxLines ?? 1) > 1
                ? TextInputAction.newline
                : TextInputAction.next),
        onSubmitted:
            widget.onSubmitted ?? (_) => FocusScope.of(context).nextFocus(),
        controller: widget.controller,
        style: Theme.of(context).textTheme.bodyMedium,
        onChanged: (value) {
          if (widget.suffixIcon == null) {
            setState(() {
              _showSufix = widget.controller.text.isNotEmpty;
            });
          }
        },
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon ??
              (_showSufix
                  ? IconButton(
                      onPressed: () {
                        widget.controller.clear();
                        setState(() {
                          _showSufix = false;
                        });
                      },
                      icon: const Icon(Icons.clear),
                    )
                  : null),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          hintText: widget.hintText,
          hintStyle: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.grey),
          enabledBorder: border,
          focusedBorder: border,
        ),
        maxLines: widget.maxLines ?? 1,
      ),
    );
  }
}
