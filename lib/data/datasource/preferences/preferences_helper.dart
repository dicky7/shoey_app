import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper{
  static const String accessTokenKey = "ACCESS_TOKEN";

  Future<void>setAccessToken(String accessToken) async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(accessTokenKey, accessToken);
  }

  Future<String> getAccessToken() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(accessTokenKey) ?? "";
  }

  Future<void> removeAccessToken() async{
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(accessTokenKey);
  }
}