import 'package:flutter/material.dart';
import 'package:rick_and_morty/constants/app_border_radius.dart';

class ImagePlaceholder extends StatelessWidget {
  const ImagePlaceholder({this.size, Key? key}) : super(key: key);
  final double? size;

  @override
  Widget build(BuildContext context) => Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          borderRadius: AppBorderRadius.small,
          color: Colors.black12,
        ),
        child: const Icon(
          Icons.broken_image_outlined,
          color: Colors.black38,
        ),
      );
}
