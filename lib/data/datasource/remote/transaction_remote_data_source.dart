import 'package:dio/dio.dart';
import 'package:shoes_app/data/models/base_response.dart';
import 'package:shoes_app/data/models/checkout_order_model.dart';
import 'package:shoes_app/data/models/transaction_model.dart';
import 'package:shoes_app/utils/exception.dart';
import 'package:shoes_app/utils/helpers/dio_error_helper.dart';

abstract class TransactionRemoteDataSource{
  Future<TransactionDataModel> getTransaction();
  Future<TransactiontModel> checkoutOrder(CheckoutOrderModel checkoutOrder);
}

class TransactionRemoteDataSourceImpl extends TransactionRemoteDataSource{
  final Dio dio;

  TransactionRemoteDataSourceImpl(this.dio);

  @override
  Future<TransactionDataModel> getTransaction() async{
    try{
      final response = await dio.get("/transactions");
      if (response.statusCode == 200) {
        final baseResponse = BaseResponse.fromJson(response.data);
        return TransactionDataModel.fromJson(baseResponse.data);
      }else{
        throw ServerException(response.statusMessage.toString());
      }
    }on DioError catch(error){
      throw ServerException(DioErrorHelper.getErrorMessage(error));
    }catch(error){
      throw ServerException(error.toString());
    }
  }


  @override
  Future<TransactiontModel> checkoutOrder(CheckoutOrderModel checkoutOrder) async{
    try{
      // first converts the CheckoutOrderModel object to a JSON representation using the toJson method.
      //and because body format is RAW(json) we need convert our model to json too.
      Map<String, dynamic> bodyCheckout = checkoutOrder.toJson();
      // sends a POST request to a server with the JSON data in the request body.
      final response = await dio.post("/checkout", data: bodyCheckout);
      if (response.statusCode == 200) {
        //If the response from the server has a status code of 200, the response body is parsed into a BaseResponse object using BaseResponse.fromJson(),
        final baseResponse = BaseResponse.fromJson(response.data);
        //and the data property of the BaseResponse object is parsed into a TransactiontModel object using TransactiontModel.fromJson().
        //This TransactiontModel object is returned as the result of the method.
        return TransactiontModel.fromJson(baseResponse.data);
      } else{
        throw ServerException(response.statusMessage.toString());
      }
    }on DioError catch(error){
      throw ServerException(DioErrorHelper.getErrorMessage(error));
    }catch(error){
      throw ServerException(error.toString());
    }
  }


}