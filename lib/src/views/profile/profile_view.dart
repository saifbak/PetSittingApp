import 'package:whiskers_away_app/src/base/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/views/profile/profile_view_model.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.nonReactive(
      viewModelBuilder: () => ProfileViewModel(),
      builder: (_, model, __) {
        return Scaffold(
          body: _Body(model),
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  final ProfileViewModel model;
  const _Body(this.model);

  @override
  Widget build(BuildContext context) {
    final screenSize = context.screenSize();

    return Container();
  }
}
