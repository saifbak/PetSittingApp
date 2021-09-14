import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/views/my_employees/my_employees_view_model.dart';
import 'package:whiskers_away_app/src/base/utils/utils.dart';

class MyEmployeesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MyEmployeesViewModel>.nonReactive(
      viewModelBuilder: () => MyEmployeesViewModel(),
      builder: (_, model, __) {
        return Scaffold(
          body: _Body(model),
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  final MyEmployeesViewModel model;
  const _Body(this.model);

  @override
  Widget build(BuildContext context) {
    final screenSize = context.screenSize();

    return Column(
      children: [],
    );
  }
}
