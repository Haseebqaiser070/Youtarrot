import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/app_svgs.dart';

class AppCachedImage extends StatelessWidget {
  final String url;
  final double? height, width;
  final Color? color;
  final BoxShape shape;
  const AppCachedImage({
    Key? key,
    this.height,
    required this.url,
    this.width,
    this.color,
    this.shape = BoxShape.rectangle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) {
        return Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: color,
            shape: shape,
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
      progressIndicatorBuilder: (context, url, progress) {
        return Center(
          child: CircularProgressIndicator(
            value: progress.progress,
            color: Colors.white,
          ),
        );
      },
      errorWidget: (context, url, error) {
        return SvgPicture.string(
          AppSvgs.person,
          height: 50,
          width: 50,
        );
      },
    );
  }
}
