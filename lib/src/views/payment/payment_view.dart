import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/shared/base_profile_view.dart';
import 'package:whiskers_away_app/src/views/payment/payment_view_model.dart';
import 'package:whiskers_away_app/src/base/utils/utils.dart';

class PaymentView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PaymentViewModel>.nonReactive(
      viewModelBuilder: () => PaymentViewModel(),
      builder: (_, model, __) {
        return Scaffold(
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

    return BaseProfileView(
      centerContent: SizedBox(),
      bottomContent: SizedBox(),
      appTopBarText: 'Payment',
    );
  }
}
