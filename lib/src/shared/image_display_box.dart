import 'package:flutter/material.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';

class ImageDisplayBox extends StatelessWidget {
  final String imgUrl;
  final double size;

  const ImageDisplayBox({
    required this.imgUrl,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.whisper,
        image: DecorationImage(
          image: AssetImage(imgUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
