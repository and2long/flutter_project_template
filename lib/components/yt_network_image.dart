import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ytlog/log.dart';

class YTNetworkImage extends StatelessWidget {
  final String _tag = 'YtNetworkImage';

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final bool showProgressIndicator;
  final FilterQuality filterQuality;

  const YTNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.showProgressIndicator = true,
    this.filterQuality = FilterQuality.low,
  });

  @override
  Widget build(BuildContext context) {
    Widget errorWidget = Container(
      color: const Color(0xFFF5F5F5),
      child: const Icon(Icons.error),
    );
    return CachedNetworkImage(
      filterQuality: filterQuality,
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      errorWidget: (context, url, error) => errorWidget,
      progressIndicatorBuilder: showProgressIndicator
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
      errorListener: (value) {
        Log.e(_tag, value);
      },
    );
  }
}
