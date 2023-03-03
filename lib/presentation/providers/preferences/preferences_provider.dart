import 'package:flutter/cupertino.dart';

import '../../../data/datasource/preferences/preferences_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider(this.preferencesHelper){
    getAccessToken();
  }

  String _isAccessToken = "";
  String get isAccessToken => _isAccessToken;

  void getAccessToken() async{
    _isAccessToken = await preferencesHelper.getAccessToken();
    notifyListeners();
    print("get access token $_isAccessToken");
  }
  void setAccessToken(String accessToken){
    preferencesHelper.setAccessToken(accessToken);
    getAccessToken();
  }
  void removeAccessToken(){
    preferencesHelper.removeAccessToken();
    getAccessToken();
  }

}
