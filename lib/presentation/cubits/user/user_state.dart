part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}
class UserLoading extends UserState {}
class UserError extends UserState {
  final String message;

  UserError(this.message);

  @override
  // TODO: implement props
  List<Object> get props => [message];
}

class UserFetchSuccess extends UserState {
  final UserModel userModel;

  UserFetchSuccess(this.userModel);

  @override
  // TODO: implement props
  List<Object> get props => [userModel];
}
