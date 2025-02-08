import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ytlog/log.dart';

class YTNetworkImage extends StatelessWidget {
  final String _tag = 'YtNetworkImage';

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final bool? showProgressIndicator;
  const YTNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit,
    this.showProgressIndicator,
  });

  @override
  Widget build(BuildContext context) {
    Widget defaultImage = Container(color: const Color(0xFFF5F5F5));
    return CachedNetworkImage(
      filterQuality: FilterQuality.high,
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit ?? BoxFit.contain,
      errorWidget: (context, url, error) => defaultImage,
      progressIndicatorBuilder: (showProgressIndicator ?? false)
          ? (context, url, progress) => Center(
                child: SizedBox(
                  width: 25,
                  height: 25,
                  child: CircularProgressIndicator(
                    value: progress.progress,
                    strokeWidth: 2,
                  ),
                ),
              )
          : null,
      placeholder: (context, url) => defaultImage,
      errorListener: (value) {
        Log.e(_tag, value);
      },
    );
  }
}
