import 'package:flutter/cupertino.dart';

import '../../data/datasource/preferences/preferences_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper});

  String _isAccessToken = "";
  String get isUsername => _isAccessToken;

  void getAccessToken() async{
    _isAccessToken = await preferencesHelper.getAccessToken();
    notifyListeners();
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
