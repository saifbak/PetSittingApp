import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:whiskers_away_app/src/configs/app_setup.locator.dart';
import 'package:whiskers_away_app/src/shared/app_spinner_dialog.dart';
import 'package:whiskers_away_app/src/views/home/home_view_model.dart';
import 'package:whiskers_away_app/src/views/home/widgets/listing_sheet.dart';
import 'package:whiskers_away_app/src/views/options_select/options_select_view_model.dart';
import 'package:whiskers_away_app/src/views/payment/widgets/payment_dialog.dart';

extension UIExt on BuildContext {
  double topSpace() => MediaQuery.of(this).padding.top;
  double appBarHeight() => AppBar().preferredSize.height;
  Size screenSize() => MediaQuery.of(this).size;
  ThemeData appTheme() => Theme.of(this);
  TextTheme textTheme() => Theme.of(this).textTheme;

  void closeKeyboardIfOpen() {
    FocusScopeNode currentFocus = FocusScope.of(this);
    if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
  }
}

class AppUtils {
  static void setupCustomDialogBuilders() {
    var dialogService = locator<DialogService>();

    final builders = {
      'payment': (context, sheetRequest, completer) =>
          PaymentDialog(request: sheetRequest, completer: completer),
      'spinner': (context, sheetRequest, completer) =>
          AppSpinnerDialog(request: sheetRequest, completer: completer)
    };

    dialogService.registerCustomDialogBuilders(builders);
  }

  static BoxShadow boxShadow1(
      {Offset? offset, double? blurRadius, double? colorOpacity}) {
    return BoxShadow(
      offset: offset ?? Offset(0, 4),
      blurRadius: blurRadius ?? 20,
      color: Colors.black.withOpacity(colorOpacity ?? .08),
    );
  }

  static void toastShow(String message) {
    Fluttertoast.showToast(msg: message, backgroundColor: Colors.tealAccent);
    // print("toast called");
  }

  static String getRoleStr(Roles role) =>
      role == Roles.petOwner ? 'Owner' : 'Pet Sitter';
}
