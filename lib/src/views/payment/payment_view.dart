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

class _Body extends StatefulWidget {
  final PaymentViewModel model;
  final user;

  const _Body(this.model, this.user);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  bool _isPressed = true;
  void _myCallback() {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = context.screenSize();
    print(widget.model.totalRewards);
    dynamic value = 0;

    return SingleChildScrollView(
      child: BasePaymentView(
        networkImage: widget.user['petsitter']['profile_img'] ?? '',
        user: widget.user,
        bottomContent: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: AppButton(
                  text: 'Make Payment',
                  onPressed:
                      _isPressed == true ? () => makePayment(context) : null),
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
                        content: widget.user['job']['location'] ?? '',
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
                                      widget.user['price'] != null
                                          ? '\$' + widget.user['price']
                                          : '',
                                      style: AppTextStyles.xxMedium(
                                        color: AppColors.darkGray,
                                      ),
                                    ),
                                    VerticalSpacing(2),
                                    Text(
                                      '-\$' +
                                          '${widget.model.currentReward.toString()}',
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
                                  'Total \$',
                                  style: AppTextStyles.xxMedium(
                                    color: AppColors.darkGray,
                                    weight: FontWeight.w500,
                                  ),
                                ),
                                HorizontalSpacing(40),
                                Text(
                                  '= \$' + widget.user['price'] != null
                                      ? widget.user['price']
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
                                      controller: widget.model.rewardsCtrl,
                                      hintText: '\$0',
                                      label: widget.model.totalRewards != null
                                          ? '\$${widget.model.totalRewards.toString()}'
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
                                          widget.model
                                              .applyRewards(widget.user);
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
                  key: widget.model.formKey,
                  child: Column(
                    children: [
                      AppTextField(
                        validator: (val) {
                          return DefaultValidator.required(val, "Card Name");
                        },
                        controller: widget.model.nameCtrl,
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
                              'assets/images/stripelogo.png',
                              width: 40,
                            ),
                          ],
                        ),
                      ),
                      AppTextField(
                        controller: widget.model.cardCtrl,
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
                              controller: widget.model.dateCtrl,
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
                                    widget.model.dateCtrl.text =
                                        DateFormat("MM/yyyy")
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
                              controller: widget.model.cvcCtrl,
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
    _myCallback();
    try {
      dynamic parsedDate = widget.model.dateCtrl.text.split('/');
      await widget.model.makePayment({
        'amount': widget.user['base_price'],
        'number': widget.model.cardCtrl.text,
        'exp_month': parsedDate[0],
        'exp_year': parsedDate[1],
        'cvc': widget.model.cvcCtrl.text,
        'petsitter_id': widget.user['petsitter_id'],
        'job_id': widget.user['job_id'],
        'rewardused': widget.model.rewardsCtrl.text,
      });
    } catch (e) {
      /* Timer(Duration(seconds: 1), () {
        model.showErrorAlert(e);
      }); */
    }
  }
}
