import 'package:shared_preferences/shared_preferences.dart';

class Shared {
  static String loginSharedPreferences = "LOGGEDINKEY";

  //save data

  static Future<bool> saveloginSharedPreference(isLogin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(loginSharedPreferences, isLogin);
  }

  //fetch data

  static Future getUserSharedPrefernces() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(loginSharedPreferences);
  }
}
