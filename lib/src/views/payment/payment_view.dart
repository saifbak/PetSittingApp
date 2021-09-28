import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/base/utils/utils.dart';
import 'package:whiskers_away_app/src/core/validators/default_validator.dart';
import 'package:whiskers_away_app/src/shared/app_button.dart';
import 'package:whiskers_away_app/src/shared/app_divider.dart';
import 'package:whiskers_away_app/src/shared/app_status_visibility_tag.dart';
import 'package:whiskers_away_app/src/shared/app_textfield.dart';
import 'package:whiskers_away_app/src/shared/base_profile_view.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/styles/app_text_styles.dart';
import 'package:whiskers_away_app/src/views/payment/payment_view_model.dart';
import 'package:whiskers_away_app/src/views/payment/widgets/label_with_content.dart';
import 'package:intl/intl.dart';

class PaymentView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PaymentViewModel>.nonReactive(
      viewModelBuilder: () => PaymentViewModel(),
      onModelReady: (model) {
        model.init();
      },
      builder: (_, model, __) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: _Body(model),
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  final PaymentViewModel model;
  const _Body(this.model);

  @override
  Widget build(BuildContext context) {
    final screenSize = context.screenSize();

    return SingleChildScrollView(
      child: BaseProfileView(
        networkImage: model.petUser.profileImg,
        user: model.petUser,
        bottomContent: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: AppButton(
                text: 'Make Payment',
                onPressed: () {
                  model.makePayment();
                },
              ),
            ),
          ],
        ),
        centerContent: Container(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LabelWithContent(
                        labelText: 'Location',
                        contentIcon: IconlyLight.location,
                        content: model.jobProposal['job']['location'],
                      ),
                      VerticalSpacing(16),
                      LabelWithContent(
                        labelText: 'Payment Summary',
                        content: Column(
                          children: [
                            /* Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '\$35 per day x 5',
                                        style: AppTextStyles.xxMedium(
                                          color: AppColors.darkGray,
                                          weight: FontWeight.w500,
                                        ),
                                      ),
                                      VerticalSpacing(2),
                                      Text(
                                        'Rewards',
                                        style: AppTextStyles.xxMedium(
                                          color: AppColors.gray,
                                          weight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  HorizontalSpacing(),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '= \$' + model.jobProposal['price'],
                                        style: AppTextStyles.xxMedium(
                                          color: AppColors.darkGray,
                                        ),
                                      ),
                                      VerticalSpacing(2),
                                      Text(
                                        '= \$10',
                                        style: AppTextStyles.xxMedium(
                                          color: AppColors.darkGray,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              VerticalSpacing(),
                              Container(
                                width: 125,
                                child: Column(
                                  children: [
                                    AppDivider(),
                                    AppDivider(),
                                  ],
                                ),
                              ),
                              VerticalSpacing(), */
                            Row(
                              children: [
                                Text(
                                  'Total',
                                  style: AppTextStyles.xxMedium(
                                    color: AppColors.darkGray,
                                    weight: FontWeight.w500,
                                  ),
                                ),
                                HorizontalSpacing(60),
                                Text(
                                  '= \$' + model.jobProposal['price'],
                                  style: AppTextStyles.xxMedium(
                                    color: AppColors.darkGray,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LabelWithContent(
                        labelText: 'Date',
                        contentIcon: IconlyLight.calendar,
                        content: model.jobProposal['job']['period'],
                      ),
                      VerticalSpacing(16),
                      /* LabelWithContent(
                          labelText: 'Rewards',
                          content: '\$10.00',
                        ),
                        VerticalSpacing(12),
                        AppStatusVisibilityTag(
                          text: 'Apply Rewards',
                          onPressed: () {},
                        ), */
                    ],
                  ),
                ],
              ),
              VerticalSpacing(20),
              AppDivider(),
              VerticalSpacing(20),
              Container(
                child: Form(
                  key: model.formKey,
                  child: Column(
                    children: [
                      AppTextField(
                        validator: (val) {
                          return DefaultValidator.required(val, "Card Name");
                        },
                        controller: model.nameCtrl,
                        hintText: 'Enter name',
                        label: 'Card Holder Name',
                        padding: EdgeInsets.zero,
                        labelIcon: IconlyLight.profile,
                        endLabel: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Powered by',
                              style: AppTextStyles.xxSmall(),
                            ),
                            HorizontalSpacing(4),
                            Image.asset(
                              'assets/images/stripe_logo.png',
                              width: 35,
                            ),
                          ],
                        ),
                      ),
                      AppTextField(
                        controller: model.cardCtrl,
                        hintText: 'Enter number',
                        label: 'Card Number',
                        padding: EdgeInsets.zero,
                        labelIcon: IconlyLight.wallet,
                        validator: (val) {
                          return DefaultValidator.required(val, "Card Number");
                        },
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: AppTextField(
                              controller: model.dateCtrl,
                              hintText: 'MM/YYYY',
                              label: 'Exp. Date',
                              padding: EdgeInsets.zero,
                              labelIcon: IconlyLight.calendar,
                              bottomSpacing: false,
                              validator: (val) {
                                return DefaultValidator.required(
                                    val, "Card Expiry");
                              },
                              onTap: () {
                                DatePicker.showDatePicker(
                                  context,
                                  showTitleActions: true,
                                  onChanged: (date) {
                                    model.dateCtrl.text = DateFormat("MM/yyyy")
                                        .format(date)
                                        .toString();
                                    print(
                                        'change ${DateFormat("MM/yyyy").format(date).toString()}');
                                  },
                                  onConfirm: (date) {
                                    print(
                                        'From Date ${DateFormat("yyyy-MM-dd").format(date).toString()}');
                                  },
                                );
                              },
                            ),
                          ),
                          HorizontalSpacing(16),
                          Expanded(
                            child: AppTextField(
                              controller: model.cvcCtrl,
                              hintText: 'XXX',
                              label: 'CVV',
                              padding: EdgeInsets.zero,
                              labelIcon: IconlyLight.wallet,
                              bottomSpacing: false,
                              validator: (val) {
                                return DefaultValidator.required(
                                    val, "Card CVV");
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        appTopBarText: 'Payment',
      ),
    );
  }
}
