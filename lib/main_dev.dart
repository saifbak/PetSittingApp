import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whiskers_away_app/src/app/app_view.dart';
import 'package:whiskers_away_app/src/base/utils/utils.dart';
import 'package:whiskers_away_app/src/configs/app_setup.locator.dart';
import 'package:whiskers_away_app/src/services/local/flavor_service.dart';
import 'package:package_info/package_info.dart';
import 'package:whiskers_away_app/src/services/local/local_storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // getting package
  final package = await PackageInfo.fromPlatform();

  setupLocator();

  // setup dialog builders
  AppUtils.setupCustomDialogBuilders();

  // app flavor init
  FlavorService.init(package);
  await LocalStorage.getInstance();

  runApp(AppView());
}
