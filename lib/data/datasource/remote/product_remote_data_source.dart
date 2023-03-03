import 'package:dio/dio.dart';

import '../../../utils/exception.dart';
import '../../../utils/helpers/dio_error_helper.dart';
import '../../models/base_response.dart';
import '../../models/category_model.dart';
import '../../models/product_model.dart';

abstract class ProductRemoteDataSource{
  Future<CategoryDataModel> getCategories();
  //function named getCategory() that returns a Future object that eventually resolves to an instance of ProductDataModel
  // and the ProductDataModel will be return List of ProductModel (json array).
  Future<ProductDataModel> getProductByCategoriesId(int categoryId);

  //this function will return of ProductModel because the respone return json object
  Future<ProductModel> getProductById(int id);
}

class ProductRemoteDataSourceImpl extends ProductRemoteDataSource{
  final Dio dio;

  ProductRemoteDataSourceImpl(this.dio);


  @override
  Future<CategoryDataModel> getCategories() async{
    try{
      final response = await dio.get("/categories");
      if (response.statusCode == 200) {
        final baseResponse = BaseResponse.fromJson(response.data);
        return CategoryDataModel.fromJson(baseResponse.data);
      }  else{
        throw ServerException(response.statusMessage.toString());
      }
    }on DioError catch(error){
      throw ServerException(DioErrorHelper.getErrorMessage(error));
    }catch(error){
      throw ServerException(error.toString());
    }
  }

  @override
  Future<ProductDataModel> getProductByCategoriesId(int categoryId) async{
    try{
      //The queryParameters field is used to pass the category ID to the API endpoint
      final response = await dio.get("/products", queryParameters: {
        "categories": categoryId
      });
      // If the status code is 200, the response data is converted to a BaseResponse object,
      // and its data property is then converted to an ProductDataModel object.
      if (response.statusCode == 200) {
        final baseResponse = BaseResponse.fromJson(response.data);
        return ProductDataModel.fromJson(baseResponse.data);
      }else{
        throw ServerException(response.statusMessage.toString());
      }
    } on DioError catch(error){
      throw ServerException(DioErrorHelper.getErrorMessage(error));
    }catch(error){
      throw ServerException(error.toString());
    }
  }

  @override
  Future<ProductModel> getProductById(int id) async{
    try{
      //The queryParameters field is used to pass the ID to the API endpoint
      final response = await dio.get("/products", queryParameters: {
        "id": id
      });
      // If the status code is 200, the response data is converted to a BaseResponse object,
      // and its data property is then converted to an ProductModel object.
      if (response.statusCode == 200) {
        final baseResponse = BaseResponse.fromJson(response.data);
        return ProductModel.fromJson(baseResponse.data);
      }else{
        throw ServerException(response.statusMessage.toString());
      }
    } on DioError catch(error){
      throw ServerException(DioErrorHelper.getErrorMessage(error));
    }catch(error){
      throw ServerException(error.toString());
    }
  }

}