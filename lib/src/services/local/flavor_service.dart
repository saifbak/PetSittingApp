import 'package:package_info/package_info.dart';
import 'package:whiskers_away_app/src/views/explore/explore_view_model.dart';

enum Env {
  prod,
  dev,
}

class FlavorService {
  FlavorService._();

  static Env? env;

  static init(PackageInfo info) {
    final flavor = info.packageName.split(".").last;
    if (flavor == 'dev') {
      env = Env.dev;
    } else {
      env = Env.prod;
    }
  }

  static String get getBaseApi {
    // return prod url
    if (env == Env.prod) {
      return "https://petsittingapp.enorness.com/api";
    }
    // return url other than prod one
    return "https://petsittingapp.enorness.com/api";
  }
}
