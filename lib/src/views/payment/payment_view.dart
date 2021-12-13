import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/base/utils/utils.dart';
import 'package:whiskers_away_app/src/core/validators/default_validator.dart';
import 'package:whiskers_away_app/src/models/User.dart';
import 'package:whiskers_away_app/src/shared/app_button.dart';
import 'package:whiskers_away_app/src/shared/app_divider.dart';
import 'package:whiskers_away_app/src/shared/app_status_visibility_tag.dart';
import 'package:whiskers_away_app/src/shared/app_textfield.dart';
import 'package:whiskers_away_app/src/shared/base_payment_view.dart';
import 'package:whiskers_away_app/src/shared/base_profile_view.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/styles/app_text_styles.dart';
import 'package:whiskers_away_app/src/views/payment/payment_view_model.dart';
import 'package:whiskers_away_app/src/views/payment/widgets/label_with_content.dart';
import 'package:intl/intl.dart';

class PaymentView extends StatelessWidget {
  final user;

  const PaymentView({
    required this.user,
  });
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PaymentViewModel>.reactive(
      viewModelBuilder: () => PaymentViewModel(),
      onModelReady: (model) {
        model.getRewards();
        model.init();
      },
      builder: (_, model, __) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: _Body(model, user),
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  final PaymentViewModel model;
  final user;

  const _Body(this.model, this.user);

  @override
  Widget build(BuildContext context) {
    final screenSize = context.screenSize();
    print(model.totalRewards);
    dynamic value = 0;

    return SingleChildScrollView(
      child: BasePaymentView(
        networkImage: user['petsitter']['profile_img'] ?? '',
        user: user,
        bottomContent: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: AppButton(
                text: 'Make Payment',
                onPressed: () {
                  makePayment(context);
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
                        content: user['job']['location'] ?? '',
                      ),
                      VerticalSpacing(16),
                      LabelWithContent(
                        labelText: 'Payment Summary',
                        content: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Price',
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
                                      user['price'] != null
                                          ? '\$' + user['price']
                                          : '',
                                      style: AppTextStyles.xxMedium(
                                        color: AppColors.darkGray,
                                      ),
                                    ),
                                    VerticalSpacing(2),
                                    Text(
                                      '-\$' +
                                          '${model.currentReward.toString()}',
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
                            VerticalSpacing(),
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
                                  '= \$' + user['base_price'] != null
                                      ? user['base_price']
                                      : '0',
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
                      // LabelWithContent(
                      //   labelText: 'Date',
                      //   contentIcon: IconlyLight.calendar,
                      //   content: model.jobProposal['job']['period'],
                      // ),
                      VerticalSpacing(16),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // LabelWithContent(
                      //   labelText: 'Location',
                      //   contentIcon: IconlyLight.location,
                      //   content: user['job']['location'] ?? '',
                      // ),
                      // VerticalSpacing(16),
                      LabelWithContent(
                        labelText: 'Rewards',
                        content: Column(
                          children: [
                            VerticalSpacing(),
                            Container(
                                width: 125,
                                child: Column(
                                  children: [
                                    AppTextField(
                                      controller: model.rewardsCtrl,
                                      hintText: '\$0',
                                      label: model.totalRewards != null
                                          ? '\$${model.totalRewards.toString()}'
                                          : '0',
                                      padding: EdgeInsets.zero,
                                      textInputType: TextInputType.number,
                                      // labelIcon: IconlyLight.wallet,
                                      // bottomSpacing: false,
                                      // validator: (val) {
                                      //   return DefaultValidator.required(
                                      //       val, "Card CVV");
                                      // },
                                    ),
                                    GestureDetector(
                                        child: AppStatusVisibilityTag(
                                            text: 'Apply Rewards'),
                                        onTap: () {
                                          model.applyRewards(user);
                                        }),
                                    VerticalSpacing(6),
                                  ],
                                )),
                            VerticalSpacing(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // LabelWithContent(
                      //   labelText: 'Date',
                      //   contentIcon: IconlyLight.calendar,
                      //   content: model.jobProposal['job']['period'],
                      // ),
                      VerticalSpacing(16),
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
                              'assets/images/autorizedotnet.png',
                              width: 40,
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
                        textInputType: TextInputType.number,
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
                              textInputType: TextInputType.number,
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

  Future<void> makePayment(ctx) async {
    try {
      dynamic parsedDate = model.dateCtrl.text.split('/');
      await model.makePayment({
        'amount': user['base_price'],
        'number': model.cardCtrl.text,
        'exp_month': parsedDate[0],
        'exp_year': parsedDate[1],
        'cvc': model.cvcCtrl.text,
        'petsitter_id': user['petsitter']['petsitter_id'],
        'job_id': user['job']['job_id'],
        'rewardused': model.rewardsCtrl.text,
      });
    } catch (e) {
      /* Timer(Duration(seconds: 1), () {
        model.showErrorAlert(e);
      }); */
    }
  }
}
