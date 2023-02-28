import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/user_model.dart';
import '../../../data/repository/user_repository.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository userRepository;

  UserCubit(this.userRepository) : super(UserInitial());

  Future<void> getUserProfil() async{
    emit(UserLoading());
    final resul = await userRepository.getUser();
    resul.fold(
          (error) => emit(UserError(error.message)),
          (user) => emit(UserFetchSuccess(user)),
    );
  }
}
