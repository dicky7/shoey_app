import 'package:dio/dio.dart';
import 'package:shoes_app/utils/exception.dart';
import 'package:shoes_app/utils/helpers/dio_error_helper.dart';

import '../../models/base_response.dart';
import '../../models/user_model.dart';

abstract class UserRemoteDataSoruce{
  Future<UserModel> getuser();
  Future<UserModel> updateUser(String name, String email, String username);
}

class UserRemoteDataSourceImpl extends UserRemoteDataSoruce{
  final Dio dio;

  UserRemoteDataSourceImpl(this.dio);

  @override
  Future<UserModel> getuser() async{
    try{
      final response = await dio.get("/user");

      final baseResponse = BaseResponse.fromJson(response.data);
      if (response.statusCode == 200) {
        return UserModel.fromJson(baseResponse.data);
      } else{
        throw ServerException(baseResponse.meta.message);
      }
    }on DioError catch(error){
      throw ServerException(DioErrorHelper.getErrorMessage(error));
    }catch(e){
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> updateUser(String name, String email, String username) async{
    try{
      //data Map object that contains the name, email and username values that will be sent in
      // the request body of the POST request to the backend API.
      final response = await dio.post("/user", data: {
        "name": name,
        "email": email,
        "username": username
      });

      // If the status code is 200, the response data is converted to a BaseResponse object,
      // and its data property is then converted to an AuthModel object.
      final baseResponse = BaseResponse.fromJson(response.data);
      if (response.statusCode == 200) {
        return UserModel.fromJson(baseResponse.data);
      } else{
        throw ServerException(baseResponse.meta.message);
      }
    }on DioError catch(error){
      throw ServerException(DioErrorHelper.getErrorMessage(error));
    }catch(e){
      throw ServerException(e.toString());
    }
  }

}