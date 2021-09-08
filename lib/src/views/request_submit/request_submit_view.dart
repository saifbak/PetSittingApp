import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/base/utils/utils.dart';
import 'package:whiskers_away_app/src/shared/app_top_bar.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/styles/app_base_styles.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/styles/app_text_styles.dart';
import 'package:whiskers_away_app/src/views/request_submit/request_submit_view_model.dart';

class RequestSubmitView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RequestSubmitViewModel>.nonReactive(
      viewModelBuilder: () => RequestSubmitViewModel(),
      builder: (_, model, __) {
        return Scaffold(
          body: _Body(model),
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  final RequestSubmitViewModel model;
  const _Body(this.model);

  @override
  Widget build(BuildContext context) {
    final screenSize = context.screenSize();

    return Column(
      children: [
        AppTopBar(text: 'Submit a Request'),
        ListView(
          shrinkWrap: true,
          padding: AppBaseStyles.horizontalPadding,
          children: [
            VerticalSpacing(16),
            Text(
              'Pet sitting services offered in yor own home are sales tax exempt, whereas pet sitting services offered in the sitter’s home are subject to standard sales tax rates',
              style: AppTextStyles.xxMedium(color: AppColors.gray),
            ),
            VerticalSpacing(16),
            DottedBorder(
              dashPattern: [6],
              borderType: BorderType.RRect,
              strokeWidth: 1.5,
              radius: Radius.circular(16),
              color: AppColors.primaryColor,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  width: double.infinity,
                  color: AppColors.primaryColor.withOpacity(.15),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/icons/add_img.png',
                        width: 50,
                      ),
                      VerticalSpacing(),
                      Text(
                        'Add image',
                        style: AppTextStyles.xxLarge(
                            color: AppColors.primaryColor),
                      )
                    ],
                  ),
                ),
              ),
            ),
            VerticalSpacing(30),
            Text(
              'Pet sitting at',
              style: AppTextStyles.xxLarge(
                weight: FontWeight.w500,
                color: AppColors.darkGray,
              ),
            ),
            VerticalSpacing(),
            Container(
              padding: EdgeInsets.all(6),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Center(
                        child: Text(
                          'Own home',
                          style: AppTextStyles.xxLarge(
                            weight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 3),
                            blurRadius: 16,
                            color: Colors.black.withOpacity(.08),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Center(
                        child: Text(
                          "Sitter's home",
                          style: AppTextStyles.xxLarge(
                            weight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 3),
                            blurRadius: 16,
                            color: Colors.black.withOpacity(.08),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 4),
                    blurRadius: 30,
                    color: Colors.black.withOpacity(.08),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
