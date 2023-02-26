import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shoes_app/data/models/auth_model.dart';

import '../../../data/datasource/preferences/preferences_helper.dart';
import '../../../data/repository/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;
  AuthCubit(this.authRepository) : super(AuthInitial());

  Future<dynamic> signUp({
    required String name,
    required  String email,
    required String username,
    required  String password,
  }) async {
    try{
      final result = await authRepository.signUp(name, email, username, password);
      result.fold(
            (error){
        },
            (success) async{

          await PreferencesHelper().setAccessToken(success.accessToken);
        },
      );

    }catch (e){
      
    }
  }
}
