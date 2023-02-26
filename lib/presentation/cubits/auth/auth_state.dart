part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final AuthModel authModel;

  AuthSuccess(this.authModel);

  @override
  // TODO: implement props
  List<Object> get props => [

  ];

}
class AuthError extends AuthState {
  final String message;

  AuthError(this.message);

  @override
  // TODO: implement props
  List<Object> get props => [
    message
  ];
}
