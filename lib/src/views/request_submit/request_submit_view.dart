import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/views/request_submit/request_submit_view_model.dart';
import 'package:whiskers_away_app/src/base/utils/utils.dart';

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
      children: [],
    );
  }
}
