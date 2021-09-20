import 'package:dio/dio.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:whiskers_away_app/src/configs/app_setup.locator.dart';
import 'package:whiskers_away_app/src/configs/app_setup.router.dart';
import 'package:whiskers_away_app/src/core/enums/role_enum.dart';
import 'package:whiskers_away_app/src/models/User.dart';
import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/models/wrappers/response_wrapper.dart';
import 'package:whiskers_away_app/src/services/local/navigation_service.dart';
import 'package:whiskers_away_app/src/services/remote/api_result.dart';
import 'package:whiskers_away_app/src/services/remote/api_service.dart';
import 'package:whiskers_away_app/src/services/remote/network_exceptions.dart';
import 'package:whiskers_away_app/src/views/explore/explore_view.dart';
import 'package:whiskers_away_app/src/views/home/home_view.dart';
import 'package:whiskers_away_app/src/views/landing/landing_view.dart';
import 'package:whiskers_away_app/src/views/my_availability/my_availability_view.dart';

class AuthService with ReactiveServiceMixin {
  ReactiveValue<User?> _user = ReactiveValue<User?>(null);
  ReactiveValue<Role?> _role = ReactiveValue<Role?>(null);

  User? get user => _user.value;
  Role? get role => _role.value;

  AuthService() {
    listenToReactiveValues([_user, _role]);
  }

  set user(User? user) {
    _user.value = user;
    role = getAuthSelectedRole();
  }

  set role(Role? val) {
    _role.value = val;
  }

  int getRoleById() {
    Role? val = role;
    /* print(
      "val------",
    );
    print(val.toString()); */
    if (val.toString() == 'Role.PET_SITTER') {
      return 4;
    } else if (val.toString() == 'Role.PET_OWNER') {
      return 3;
    } else {
      return 4;
    }
  }

  Role getAuthSelectedRole() {
    int? roleID = user?.roleId;
    if (roleID == 4) {
      return Role.PET_SITTER;
    } else if (roleID == 3) {
      return Role.PET_OWNER;
    } else {
      return Role.PET_OWNER;
    }
  }

  navigateHomeScreen() {
    Role selected = getAuthSelectedRole();
    if (selected == Role.PET_SITTER) {
      NavService.landing(
        arguments: LandingViewArguments(
          navBarItems: [
            // NavBarItem(
            //   IconlyLight.search,
            //   'Bookings',
            //   HomeView(),
            // ),
            // NavBarItem(
            //   IconlyLight.user2,
            //   'My Employees',
            //   MyEmployeesView(),
            // ),
            NavBarItem(
              IconlyLight.search,
              'Explore',
              ExploreView(),
            ),
            NavBarItem(
              IconlyLight.work,
              'My Availability',
              MyAvailabilityView(),
            ),
          ],
        ),
      );
    } else {
      NavService.home();
    }
  }

  bool isOwner() {
    if (role == null) {
      return false;
    }
    if (role == Role.PET_OWNER) {
      return true;
    } else {
      return false;
    }
  }

  bool isPetSitter() {
    if (role == null) {
      return false;
    }
    if (role == Role.PET_SITTER) {
      return true;
    } else {
      return false;
    }
  }
}
