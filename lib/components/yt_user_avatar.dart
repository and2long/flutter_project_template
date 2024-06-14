import 'package:flutter/material.dart';
import 'package:flutter_project_template/components/yt_network_image.dart';
import 'package:flutter_project_template/theme.dart';

class YTUserAvatar extends StatelessWidget {
  final String? url;
  final double? size;
  final EdgeInsetsGeometry? margin;

  const YTUserAvatar({super.key, required this.url, this.size, this.margin});

  @override
  Widget build(BuildContext context) {
    double rSize = size ?? 70;
    return Container(
      margin: margin,
      child: ClipOval(
        child: url == null || url!.isEmpty
            ? Container(
                width: rSize,
                height: rSize,
                color: dividerColor,
              )
            : YTNetworkImage(
                fit: BoxFit.cover,
                imageUrl: url!,
                width: rSize,
                height: rSize,
              ),
      ),
    );
  }
}
