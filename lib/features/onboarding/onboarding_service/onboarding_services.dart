import 'package:shared_preferences/shared_preferences.dart';

class OnboardingServices {
  static late SharedPreferences sharedPrefs;
  static Future initialSharedPreference() async {
    sharedPrefs = await SharedPreferences.getInstance();
  }

 static bool isFirstTime() {
    return sharedPrefs.getBool('isFirstTime') ?? true;
  }

 static setFirstTime() {
    sharedPrefs.setBool('isFirstTime', false);
  }
}
