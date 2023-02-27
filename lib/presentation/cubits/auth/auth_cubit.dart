import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shoes_app/data/models/auth_model.dart';

import '../../../data/datasource/preferences/preferences_helper.dart';
import '../../../data/repository/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;
  AuthCubit(this.authRepository) : super(AuthInitial());

  void signIn({
    required  String email,
    required  String password,
  }) async {
    emit(AuthLoading());
    final result = await authRepository.signIn(email, password);
    result.fold(
          (error) => emit(AuthError(error.message)),
          (success) async {
            emit(AuthSuccess(success));
          },
    );
  }

  void signUp({
    required String name,
    required  String email,
    required String username,
    required  String password,
  }) async {
    emit(AuthLoading());
    final result = await authRepository.signUp(name, email, username, password);
    result.fold(
          (error) => emit(AuthError(error.message)),
          (success) => emit(AuthSuccess(success)),
    );
  }

}
