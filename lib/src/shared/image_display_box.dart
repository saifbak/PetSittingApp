import 'package:flutter/material.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';

class ImageDisplayBox extends StatelessWidget {
  final String? imgUrl;
  final double size;
  final String? assetDefaultImage;

  const ImageDisplayBox({
    this.imgUrl,
    this.size = 40,
    this.assetDefaultImage = 'pet.jpg',
  });

  @override
  Widget build(BuildContext context) {
    print(this.imgUrl);
    print(this.assetDefaultImage);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.whisper,
        image: DecorationImage(
          image: imgUrl != null
              ? NetworkImage(imgUrl!)
              : AssetImage('assets/images/' + assetDefaultImage!)
                  as ImageProvider,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
