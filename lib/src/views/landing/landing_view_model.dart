import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LandingViewModel extends BaseViewModel {
  final Map<int, Widget> _viewCache = Map<int, Widget>();

  int _currentTabIndex = 0;
  int get currentTabIndex => _currentTabIndex;
  set currentTabIndex(int val) {
    _currentTabIndex = val;
    notifyListeners();
  }

  Widget getViewForIndex(int index) {
    if (!_viewCache.containsKey(index)) {
      switch (index) {
        case 0:
          _viewCache[index] = SizedBox();
          break;
        case 1:
          _viewCache[index] = SizedBox();
          break;
      }
    }
    return _viewCache[index]!;
  }
}
