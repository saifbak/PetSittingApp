import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/base/utils/utils.dart';
import 'package:whiskers_away_app/src/shared/app_button.dart';
import 'package:whiskers_away_app/src/shared/app_top_bar.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/styles/app_base_styles.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/styles/app_text_styles.dart';
import 'package:whiskers_away_app/src/views/home/home_view_model.dart';
import 'package:whiskers_away_app/src/views/options_select/options_select_view_model.dart';
import 'package:whiskers_away_app/src/views/per_details/pet_details_view_model.dart';

class PetDetailsView extends StatelessWidget {
  final Request request;
  final Roles role;

  const PetDetailsView({
    required this.request,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PetDetailsViewModel>.nonReactive(
      viewModelBuilder: () => PetDetailsViewModel(),
      builder: (context, model, __) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark.copyWith(
            systemNavigationBarColor: Colors.white,
            statusBarColor: Colors.transparent,
          ),
          child: Scaffold(
            body: _Body(model, request, role),
          ),
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  final PetDetailsViewModel model;
  final Request request;
  final Roles role;

  const _Body(this.model, this.request, this.role);

  @override
  Widget build(BuildContext context) {
    final screenSize = context.screenSize();

    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: screenSize.width,
              height: screenSize.height / 2.25,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 4),
                    blurRadius: 15,
                    color: Colors.black.withOpacity(.3),
                  ),
                ],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                image: DecorationImage(
                    image: AssetImage(
                      'assets/images/pet_pic.jpg',
                    ),
                    fit: BoxFit.cover),
              ),
            ),
            AppTopBar(
              text: '',
              color: Colors.white,
            ),
            Positioned(
              left: screenSize.width / 2 - ((screenSize.width / 1.5) / 2),
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 12.0,
                      sigmaY: 12.0,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: screenSize.width / 1.5,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.3),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            request.dogBreed,
                            style: AppTextStyles.xLarge(
                              color: Colors.white,
                              weight: FontWeight.w700,
                            ),
                          ),
                          VerticalSpacing(4),
                          Text(
                            '${request.dogWeight.toInt()} lbs',
                            style: AppTextStyles.xxLarge(
                              color: Colors.white,
                              weight: FontWeight.w500,
                            ),
                          ),
                          VerticalSpacing(6),
                          Row(
                            children: [
                              Icon(
                                IconlyBold.location,
                                size: 16,
                                color: Colors.white,
                              ),
                              HorizontalSpacing(4),
                              Text(
                                request.location,
                                style: AppTextStyles.xMedium(
                                  color: Colors.white,
                                  weight: FontWeight.w500,
                                ),
                              ),
                              Spacer(),
                              Text(
                                '${request.dogAge} years old',
                                style: AppTextStyles.xMedium(
                                  color: Colors.white,
                                  weight: FontWeight.w500,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        VerticalSpacing(28),
        Expanded(
          child: ListView(
            padding: AppBaseStyles.horizontalPadding,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.whisper,
                      image: DecorationImage(
                        image: AssetImage('assets/images/profile_pic.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  HorizontalSpacing(10),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Jessi Smith',
                              style: AppTextStyles.xLarge(
                                weight: FontWeight.w500,
                              ),
                            ),
                            VerticalSpacing(6),
                            Text(
                              AppUtils.getRoleStr(role),
                              style: AppTextStyles.xxLarge(
                                color: AppColors.gray,
                              ),
                            )
                          ],
                        ),
                        Text(
                          'May 25, 2021',
                          style: AppTextStyles.xMedium(),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              VerticalSpacing(12),
              Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cursus et scelerisque risus quam porta aenean sed cursus. Vestibulum aliquet eros, euismod platea felis velit. Consectetur arcu proin vel laoreet.\n\nAnte in fames scelerisque ridiculus elementum ornare pellentesque arcu. Volutpat nec nunc, ante in fames scelerisque ridiculus elementum ornare pellentesque arcu. Volutpat nec nunc. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cursus et scelerisque risus quam porta aenean sed cursus. Vestibulum aliquet eros, euismod platea felis velit. Consectetur arcu proin vel laoreet.\n\nAnte in fames scelerisque ridiculus elementum ornare pellentesque arcu. Volutpat nec nunc, ante in fames scelerisque ridiculus elementum ornare pellentesque arcu. Volutpat nec nunc."),
            ],
          ),
        ),
        if (role == Roles.petSitter) ...[
          VerticalSpacing(12),
          Padding(
            padding: AppBaseStyles.horizontalPadding,
            child: Row(
              children: [
                AppButton(
                  horizontalPadding: 10,
                  child: Icon(
                    Icons.favorite,
                    size: 20,
                    color: Colors.white,
                  ),
                  text: '',
                ),
                HorizontalSpacing(16),
                Expanded(child: AppButton(text: 'Request to pet sit')),
              ],
            ),
          ),
          AppSpacing(context).bottomSpacing,
        ],
      ],
    );
  }
}
