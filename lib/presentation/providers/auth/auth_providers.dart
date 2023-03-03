import 'package:flutter/cupertino.dart';
import 'package:shoes_app/data/datasource/preferences/preferences_helper.dart';
import 'package:shoes_app/data/models/auth_model.dart';
import 'package:shoes_app/data/models/user_model.dart';
import 'package:shoes_app/data/repository/auth_repository.dart';
import 'package:shoes_app/utils/state_enum.dart';

class AuthProviders extends ChangeNotifier {
  final AuthRepository authRepository;

  AuthProviders(this.authRepository);


  ResultState _state = ResultState.Initial;
  ResultState get state => _state;

  String _message = "";
  String get message => _message;

  late AuthModel _authModel;
  AuthModel get authModel => _authModel;

  //this function you can use after post data and you need to change the ResultState to initial,
  // if you don't doit the current state still the same with previus state
  void setPostState(ResultState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<dynamic> signIn({required String email, required String password}) async{
    try{
      //initial state from initial to loading
      //and notifyListeners() used to notify any listeners that the state of the object
      _state = ResultState.Loading;
      notifyListeners();
      final result = await authRepository.signIn(email, password);
      result.fold(
        //If result.fold() returns an error (Left), it sets the state of _state to ResultState.Error,
        // calls notifyListeners(), and sets the value of _message to the error's message.
       (error) {
          _state = ResultState.Error;
          notifyListeners();
          return _message = error.message;
        },
        //If result.fold() returns success (Right), it sets the state of _state to ResultState.Success,
        // and calls notifyListeners(). sets the value of _message to "Sign In Success.
         (success) async{
          _state = ResultState.Success;
          _authModel = success;
          notifyListeners();
          return _message = "Sign In Success, Welcome to Shoey";
        },
      );

    }catch (e){
      _state = ResultState.Error;
      notifyListeners();
      return _message = e.toString();
    }
  }

  Future<dynamic> signUp({
    required String name,
    required  String email,
    required String username,
    required  String password,
    }) async {
    try{
      _state = ResultState.Loading;
      notifyListeners();
      final result = await authRepository.signUp(name, email, username, password);
      result.fold(
        (error){
          _state = ResultState.Error;
          notifyListeners();
          return _message = error.message;
        },
        (success) async{
          _state = ResultState.Success;
          notifyListeners();
          await PreferencesHelper().setAccessToken(success.accessToken);
          print(success.accessToken);
          return _message = "Sign Up Success, Please Login First";
        },
      );

    }catch (e){
      _state = ResultState.Error;
      notifyListeners();
      return _message = e.toString();
    }
  }
}
