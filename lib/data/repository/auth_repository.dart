import 'package:shoes_app/data/datasource/remote/auth_remote_data_source.dart';
import 'package:shoes_app/data/models/auth_model.dart';
import 'package:shoes_app/utils/exception.dart';
import 'package:shoes_app/utils/failure.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository{
  Future<Either<Failure, AuthModel>>signIn(String email, String password);
  Future<Either<Failure, AuthModel>>signUp(String name, String email, String username, String password);
}

class AuthRepositoryImpl extends AuthRepository{
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);


  //this method returns an Either instance, indicating success or failure of the sign-in operation,
  // and it handles both expected and unexpected errors.
  @override
  Future<Either<Failure, AuthModel>> signIn(String email, String password) async{
    try{
      //It calls the remoteDataSource.signIn() method, passing in the email and password.
      //If the operation is successful, it returns a Right instance wrapping the result value.
      final result = await remoteDataSource.signIn(email, password);
      return Right(result);

      //If the remoteDataSource.signIn() call throws a ServerException, it catches the exception
      // and returns a Left instance wrapping a ServerFailure instance with an empty message.
    }on ServerException{
      return Left(ServerFailure(""));
    }catch (e){
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthModel>> signUp(String name, String email, String username, String password) async{
    try{
      final response = await remoteDataSource.signUp(name, email, username, password);
      return Right(response);

    }on ServerException catch(e){
      return Left(ServerFailure(e.message));
    }catch (e){
      return Left(ServerFailure(e.toString()));
    }
  }

}