import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:whiskers_away_app/src/shared/app_button.dart';
import 'package:whiskers_away_app/src/shared/app_divider.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/styles/app_text_styles.dart';

class PaymentDialog extends StatelessWidget {
  const PaymentDialog({
    required this.request,
    required this.completer,
  });
  final DialogRequest request;
  final Function(DialogResponse) completer;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            VerticalSpacing(),
            Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.primaryColor.withOpacity(.075),
                  radius: 50,
                ),
                CircleAvatar(
                  backgroundColor: AppColors.primaryColor.withOpacity(.25),
                  radius: 37.5,
                ),
                Icon(
                  Icons.check_rounded,
                  size: 36,
                  color: AppColors.primaryColor,
                )
              ],
            ),
            VerticalSpacing(24),
            Text(
              'Payment Complete',
              style: AppTextStyles.xLarge(
                color: AppColors.primaryColor,
                weight: FontWeight.w500,
              ),
            ),
            VerticalSpacing(16),
            AppDivider(),
            VerticalSpacing(16),
            Text(
              "You are set for pet sitting services.\nThank you!",
              textAlign: TextAlign.center,
            ),
            VerticalSpacing(24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppButton(
                  text: 'Continue',
                  onPressed: () {},
                  horizontalPadding: 40,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
