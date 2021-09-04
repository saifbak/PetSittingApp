import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/shared/base_view.dart';
import 'package:whiskers_away_app/src/shared/app_button.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/views/onboarding/onboarding_view_model.dart';
import 'package:whiskers_away_app/src/base/utils/utils.dart';

class OnBoardingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OnBoardingViewModel>.nonReactive(
      viewModelBuilder: () => OnBoardingViewModel(),
      builder: (_, model, __) {
        return Scaffold(
          body: BaseView(
            bgImageUrl: 'assets/images/bg_img_2.png',
            child: _Body(model),
          ),
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  final OnBoardingViewModel model;
  const _Body(this.model);

  @override
  Widget build(BuildContext context) {
    final screenSize = context.screenSize();

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        VerticalSpacing(context.topSpace() + screenSize.height * .05),
        Container(
            width: screenSize.width / 2.25,
            child: Hero(
              tag: 'logo_text',
              child: Image.asset(
                'assets/images/logo_text.png',
              ),
            )),
        Expanded(
          child: PageView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: model.onBoardingContent.length,
            onPageChanged: (currentIndex) {
              model.pageIndex = currentIndex;
            },
            itemBuilder: (_, index) {
              final pageContent = model.onBoardingContent[index];

              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: screenSize.width / 1.25,
                    child: Image.asset(
                      pageContent['imgUrl'],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.all(22),
                    child: Column(
                      children: [
                        // TODO: proper styling of below text widgets using theme
                        Text(
                          pageContent['card_heading'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Airbnb Cereal',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        VerticalSpacing(10),
                        Text(
                          pageContent['card_about_app_text'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Airbnb Cereal',
                          ),
                        ),
                        // TODO: Divider implementation
                        VerticalSpacing(10),
                        Text(
                          pageContent['card_desc'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Airbnb Cereal',
                          ),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 4),
                          blurRadius: 30,
                          color: Colors.black.withOpacity(.08),
                        )
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: Row(
            children: [
              AppButton(
                text: 'Sign Up',
                fullWidth: true,
              ),
              HorizontalSpacing(18),
              AppButton(
                text: 'Log In',
                type: AppButtonType.outline,
                fullWidth: true,
              ),
            ],
          ),
        ),
        VerticalSpacing(screenSize.height * .04),
        SizedBox(
          height: model.pageIndicatorSize,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (_, index) {
              return _IndicatorCircle(index);
            },
            separatorBuilder: (_, __) => HorizontalSpacing(),
            itemCount: model.onBoardingContent.length,
          ),
        ),
        VerticalSpacing(screenSize.height * .04),
      ],
    );
  }
}

class _IndicatorCircle extends ViewModelWidget<OnBoardingViewModel> {
  final int index;
  _IndicatorCircle(this.index);

  @override
  Widget build(BuildContext context, OnBoardingViewModel model) {
    return AnimatedContainer(
      decoration: BoxDecoration(
        color: index == model.pageIndex
            ? AppColors.primaryColor
            : AppColors.whisper,
        shape: BoxShape.circle,
      ),
      duration: Duration(milliseconds: 200),
      width: model.pageIndicatorSize,
      height: model.pageIndicatorSize,
    );
  }
}
