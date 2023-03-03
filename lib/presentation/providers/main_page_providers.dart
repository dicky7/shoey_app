import 'package:flutter/cupertino.dart';

class MainPageProviders extends ChangeNotifier{
  int _indexPage = 0;
  int get indexPage => _indexPage;

  Future<void> setPage(int index)async {
    _indexPage = index;
    notifyListeners();
  }
}