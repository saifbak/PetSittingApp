import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whiskers_away_app/src/base/utils/constants.dart';
import 'package:whiskers_away_app/src/services/local/navigation_service.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/views/splash/splash_view.dart';

class AppView extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.appTitle,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: NavService.onGenerateRoute,
      navigatorKey: NavService.key,
      home: SplashView(),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Airbnb Cereal',
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: AppColors.primaryColor,
        ),
        scrollbarTheme: ScrollbarThemeData(
          isAlwaysShown: true,
          mainAxisMargin: -6,
          thickness: MaterialStateProperty.all(3.5),
          radius: Radius.circular(10),
          thumbColor: MaterialStateProperty.all(AppColors.primaryColor),
        ),
      ),
      builder: (context, child) {
        return Stack(
          children: [
            NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overscroll) {
                overscroll.disallowGlow();
                return true;
              },
              child: child!,
            ),
          ],
        );
      },
    );
  }
}
