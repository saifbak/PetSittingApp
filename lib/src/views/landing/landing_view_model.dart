import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/views/landing/landing_view.dart';

class LandingViewModel extends BaseViewModel {
  LandingViewModel(this.navBarItems);
  final List<NavBarItem> navBarItems;

  final Map<int, Widget> _viewCache = Map<int, Widget>();

  int _currentTabIndex = 0;
  int get currentTabIndex => _currentTabIndex;
  set currentTabIndex(int val) {
    _currentTabIndex = val;
    notifyListeners();
  }

  Widget getViewForIndex(int index) {
    if (!_viewCache.containsKey(index)) {
      _viewCache[index] = navBarItems
          .firstWhere((element) => navBarItems.indexOf(element) == index)
          .view;
    }
    return _viewCache[index]!;
  }
}
