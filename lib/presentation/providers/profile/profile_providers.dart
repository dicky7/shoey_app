import 'package:flutter/cupertino.dart';
import 'package:shoes_app/data/models/user_model.dart';
import 'package:shoes_app/utils/state_enum.dart';

import '../../../data/repository/user_repository.dart';

class ProfileProviders extends ChangeNotifier{
  final UserRepository userRepository;

  ProfileProviders(this.userRepository);

  //note! (1 state for 1 function)
  // each function must have their own state and message, with 1 state on 1 function make app not confused
  ResultState _stateGetUser = ResultState.Initial;
  ResultState get stateGetUser => _stateGetUser;

  late UserModel _userModel;
  UserModel get userModel => _userModel;
  String _messageGetUser = "";
  String get messageGetUser => _messageGetUser;

  ResultState _stateUpdateUser = ResultState.Initial;
  ResultState get stateUpdateUser => _stateUpdateUser;
  String _messageUpdateUser =  "";
  String get messageUpdateUser => _messageUpdateUser;

  //this function you can use after post data and you need to change the ResultState to initial,
  // if you don't doit the current state still the same with previus state
  void setPostState(ResultState newState){
    _stateUpdateUser = newState;
    notifyListeners();
  }


  //we make function private with add undescore and this function only can be access inside the class
  Future<void> getUserProfile() async{
    _stateGetUser = ResultState.Loading;
    notifyListeners();

    final result = await userRepository.getUser();
    result.fold(
          (error) {
        _stateGetUser = ResultState.Error;
        notifyListeners();
        return _messageGetUser = error.message;
      },
          (user) {
        _stateGetUser = ResultState.Success;
        notifyListeners();
        return _userModel = user;
      },
    );
  }

  //we make function private with add undescore and this function only can be access inside the class
  Future<void> updateUserProfile(
      {required String fullname, required String username, required String email}) async {
    _stateUpdateUser = ResultState.Loading;
    notifyListeners();

    final result = await userRepository.updateUser(fullname, email, username);
    result.fold(
          (error) {
        _stateUpdateUser = ResultState.Error;
        notifyListeners();
        return _messageUpdateUser = error.message;
      },
          (user) {
        _stateUpdateUser = ResultState.Success;
        notifyListeners();
        return _messageUpdateUser = "Congratulations, the profile has been successfully changed";
      },
    );
  }
}