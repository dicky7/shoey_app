import 'package:dio/dio.dart';
import 'package:shoes_app/data/models/base_response.dart';
import 'package:shoes_app/utils/exception.dart';
import 'package:shoes_app/utils/helpers/dio_error_helper.dart';
import 'package:http/http.dart' as http;
import '../../models/auth_model.dart';

abstract class AuthRemoteDataSource{
  //function named signUp that returns a Future object that eventually resolves to an instance of AuthModel.
  Future<AuthModel> signUp(String name, String email, String username, String password);
  Future<AuthModel> signIn(String email, String password);
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource{
  final Dio dio;

  AuthRemoteDataSourceImpl(this.dio);

  
  @override
  Future<AuthModel> signIn(String email, String password) async{
    //Map object that contains the email and password values that will be sent in
    // the request body of the POST request to the backend API.
    var body = {
      "email": email,
      "password": password
    };

    try {
      final response = await dio.post("/login", data: body);
      // If the status code is 200, the response data is converted to a BaseResponse object,
      // and its data property is then converted to an AuthModel object.
      if (response.statusCode == 200) {
        final baseResponse = BaseResponse.fromJson(response.data);
        return AuthModel.fromJson(baseResponse.data);
      } else {
        throw ServerException(response.statusMessage.toString());
      }
    }on DioError catch(error){
      throw ServerException(DioErrorHelper.getErrorMessage(error));
    }catch (e){
      throw ServerException(e.toString());

    }
  }

  @override
  Future<AuthModel> signUp(String name, String email, String username, String password) async{
    var body = {
      "name": name,
      "email": email,
      "username": username,
      "password": password
    };

    try{
      final response = await dio.post("/register", data: body);
      if (response.statusCode == 200) {
        final baseResponse = BaseResponse.fromJson(response.data);
        return AuthModel.fromJson(baseResponse.data);
      }else{
        throw ServerException(response.statusMessage.toString());
      }
    }on DioError catch(error){
      throw ServerException(DioErrorHelper.getErrorMessage(error));
    }catch (e){
      throw ServerException(e.toString());
    }
  }

}