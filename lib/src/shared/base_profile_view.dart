import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:whiskers_away_app/src/models/User.dart';
import 'package:whiskers_away_app/src/shared/app_base_card.dart';
import 'package:whiskers_away_app/src/shared/app_top_bar.dart';
import 'package:whiskers_away_app/src/base/utils/utils.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/styles/app_base_styles.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/styles/app_text_styles.dart';
import 'dart:io';

class BaseProfileView extends StatelessWidget {
  const BaseProfileView(
      {required this.centerContent,
      required this.bottomContent,
      required this.appTopBarText,
      this.user,
      this.metaData,
      this.isEditable = false,
      this.networkImage,
      this.uploadImage,
      this.defaultAssetImage = 'assets/images/profile.png',
      this.onClicked});

  final Widget centerContent;
  final Widget bottomContent;
  final String appTopBarText;
  final File? uploadImage;
  final String? defaultAssetImage;
  final String? networkImage;
  final User? user;
  final dynamic metaData;
  final bool isEditable;
  final VoidCallback? onClicked;

  @override
  Widget build(BuildContext context) {
    final screenSize = context.screenSize();

    final profileAvatarSize = 120.0;

    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: screenSize.height / 2.75,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
            ),
            Column(
              children: [
                AppTopBar(
                  text: appTopBarText,
                  color: Colors.white,
                  centerText: true,
                ),
                VerticalSpacing(16),
                Stack(
                  children: [
                    AppBaseCard(
                      padding: EdgeInsets.zero,
                      height: screenSize.height -
                          (profileAvatarSize +
                              context.topSpace() +
                              screenSize.height * .09 +
                              42),
                      margin: EdgeInsets.only(
                        top: profileAvatarSize / 2,
                        left: 20,
                        right: 20,
                      ),
                      child: ListView(
                        padding: EdgeInsets.all(16),
                        children: [
                          VerticalSpacing((profileAvatarSize / 2) - 6),
                          Center(
                            child: Text(
                              user?.name ?? '',
                              style: AppTextStyles.xLarge(
                                color: AppColors.darkGray,
                                weight: FontWeight.w500,
                              ),
                            ),
                          ),
                          VerticalSpacing(4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                IconlyBold.location,
                                size: 16,
                                color: AppColors.primaryColor,
                              ),
                              HorizontalSpacing(4),
                              Text(
                                user?.address ?? '',
                                style: AppTextStyles.xxMedium(
                                  color: AppColors.darkGray,
                                ),
                              ),
                            ],
                          ),
                          VerticalSpacing(4),
                          (metaData != null && metaData['price'] != null)
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '\$',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.primaryColor),
                                    ),
                                    HorizontalSpacing(3),
                                    Text(
                                      metaData['price'],
                                      style: AppTextStyles.xxMedium(
                                        color: AppColors.darkGray,
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),
                          VerticalSpacing(12),
                          centerContent,
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: isEditable
                          ? Stack(
                              children: [
                                InkWell(
                                  onTap: () {
                                    if (onClicked != null) {
                                      onClicked!();
                                    }
                                  },
                                  child: buildProfileImage(profileAvatarSize),
                                ),
                                isEditable
                                    ? Positioned(
                                        child: buildEditIcon(),
                                        right: 10,
                                        bottom: 0,
                                      )
                                    : Container(),
                              ],
                            )
                          : buildProfileImage(profileAvatarSize),
                    ),
                  ],
                ),
                VerticalSpacing(20),
                Padding(
                  padding: AppBaseStyles.horizontalPadding,
                  child: bottomContent,
                ),
                AppSpacing(context).bottomSpacing,
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget buildEditIcon() => ClipOval(
        child: Container(
          color: AppColors.primaryColor,
          padding: EdgeInsets.all(6.0),
          child: Icon(
            Icons.edit,
            color: Colors.white,
            size: 20,
          ),
        ),
      );

  Widget buildProfileImage(profileAvatarSize) {
    return Container(
      width: profileAvatarSize,
      height: profileAvatarSize,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: (this.uploadImage == null && this.networkImage != null)
              ? NetworkImage(this.networkImage!)
              : (this.uploadImage != null
                  ? FileImage(uploadImage!)
                  : AssetImage(this.defaultAssetImage!) as ImageProvider),
        ),
        color: Colors.white,
        border: Border.all(
          color: AppColors.primaryColor,
          width: 3,
        ),
        shape: BoxShape.circle,
      ),
    );
  }
}
