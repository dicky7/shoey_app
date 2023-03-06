import 'package:dartz/dartz.dart';
import 'package:shoes_app/data/datasource/remote/transaction_remote_data_source.dart';
import 'package:shoes_app/data/models/checkout_order_model.dart';
import 'package:shoes_app/data/models/transaction_model.dart';
import 'package:shoes_app/utils/exception.dart';
import 'package:shoes_app/utils/failure.dart';

abstract class TransactionRepository{
  Future<Either<Failure, List<TransactiontModel>>> getTransaction();
  Future<Either<Failure, TransactiontModel>> checkoutOrder(CheckoutOrderModel checkoutOrder);
}

class TransactionRepositoryImpl extends TransactionRepository{
  final TransactionRemoteDataSource transactionRemote;

  TransactionRepositoryImpl(this.transactionRemote);
  @override
  Future<Either<Failure, List<TransactiontModel>>> getTransaction() async{
    try{
      final result = await transactionRemote.getTransaction();
      return Right(result.data);
    }on ServerException catch(e){
      return Left(ServerFailure(e.message));
    }catch(e){
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TransactiontModel>> checkoutOrder(CheckoutOrderModel checkoutOrder) async{
    try{
      final result = await transactionRemote.checkoutOrder(checkoutOrder);
      return Right(result);
    }on ServerException catch(e){
      return Left(ServerFailure(e.message));
    }catch(e){
      return Left(ServerFailure(e.toString()));
    }
  }

}