import 'package:dartz/dartz.dart';
import 'package:shoes_app/data/datasource/remote/user_remote_data_source.dart';
import 'package:shoes_app/data/models/user_model.dart';
import 'package:shoes_app/utils/exception.dart';
import 'package:shoes_app/utils/failure.dart';

abstract class UserRepository{
  Future<Either<Failure, UserModel>> getUser();
  Future<Either<Failure, UserModel>> updateUser(String name, String email, String username);
}

class UserRepositoryImpl extends UserRepository{
  final UserRemoteDataSoruce remoteDataSoruce;

  UserRepositoryImpl(this.remoteDataSoruce);

  @override
  Future<Either<Failure, UserModel>> getUser() async{
    try{
      final result = await remoteDataSoruce.getuser();
      return Right(result);
    }on ServerException catch(error){
      return Left(ServerFailure(error.message));
    }catch(error){
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> updateUser(String name, String email, String username) async{
    try{
      final result = await remoteDataSoruce.updateUser(name, email, username);
      return Right(result);
    }on ServerException catch(error){
      return Left(ServerFailure(error.message));
    }catch(error){
      return Left(ServerFailure(error.toString()));
    }
  }

}