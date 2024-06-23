import 'package:flutter/material.dart';
import 'package:flutter_project_template/constants.dart';

class YTTile extends StatelessWidget {
  final Widget? leading;
  final Widget? trailing;
  final bool? hideLeading;
  final String title;
  final String? subtitle;
  final GestureTapCallback? onTap;
  const YTTile({
    super.key,
    this.leading,
    this.trailing,
    required this.title,
    this.subtitle,
    this.onTap,
    this.hideLeading,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: tileHeight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          border: Border(bottom: Divider.createBorderSide(context)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Offstage(
                  offstage: leading == null || (hideLeading ?? false),
                  child: Container(
                    width: 35,
                    alignment: Alignment.centerLeft,
                    child: leading,
                  ),
                ),
                Text(title),
              ],
            ),
            Row(
              children: [
                Text(
                  subtitle ?? '',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.black54),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 8),
                  child: trailing,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
