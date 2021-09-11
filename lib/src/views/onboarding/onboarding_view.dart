import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/services/local/navigation_service.dart';
import 'package:whiskers_away_app/src/shared/app_divider.dart';
import 'package:whiskers_away_app/src/shared/base_view.dart';
import 'package:whiskers_away_app/src/shared/app_button.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/styles/app_text_styles.dart';
import 'package:whiskers_away_app/src/views/onboarding/onboarding_view_model.dart';
import 'package:whiskers_away_app/src/base/utils/utils.dart';

class OnBoardingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OnBoardingViewModel>.reactive(
      viewModelBuilder: () => OnBoardingViewModel(),
      builder: (_, model, __) {
        return Scaffold(
          body: BaseView(
            bgImageUrl: model.onBoardingContent[model.pageIndex]['bg_imgUrl'],
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
        Row(
          children: [
            IconButton(
              onPressed: () => NavService.popOut,
              splashRadius: 24,
              padding: EdgeInsets.only(left: 30),
              constraints: BoxConstraints(),
              icon: Icon(Icons.arrow_back_ios),
              color: AppColors.primaryColor,
            ),
            Spacer(),
            Container(
              width: screenSize.width / 2.25,
              child: Hero(
                tag: 'logo_text',
                child: Image.asset(
                  'assets/images/logo_text.png',
                ),
              ),
            ),
            HorizontalSpacing(50),
            Spacer(),
          ],
        ),
        VerticalSpacing(screenSize.height * .025),
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
                    width: screenSize.width / 1.35,
                    child: Image.asset(
                      pageContent['imgUrl'],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: screenSize.height * .025,
                    ),
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          pageContent['card_heading'],
                          textAlign: TextAlign.center,
                          style: AppTextStyles.xxLarge(weight: FontWeight.w700),
                        ),
                        VerticalSpacing(10),
                        Text(
                          pageContent['card_about_app_text'],
                          textAlign: TextAlign.center,
                          style: AppTextStyles.xxMedium(),
                        ),
                        VerticalSpacing(10),
                        AppDivider(),
                        VerticalSpacing(10),
                        Text(
                          pageContent['card_desc'],
                          textAlign: TextAlign.center,
                          style: AppTextStyles.xxMedium(),
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
                onPressed: NavService.signup,
              ),
              HorizontalSpacing(18),
              AppButton(
                text: 'Log In',
                type: AppButtonType.outline,
                fullWidth: true,
                onPressed: NavService.login,
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
