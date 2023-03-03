import 'package:dartz/dartz.dart';
import 'package:shoes_app/data/datasource/db/cart_local_data_source.dart';
import 'package:shoes_app/data/models/table/cart_table.dart';
import 'package:shoes_app/utils/failure.dart';

import '../../utils/exception.dart';

abstract class CartRepository{
  Future<Either<Failure, List<CartTable>>> getListCart();
  Future<Either<Failure, String>> insertCart(CartTable cart);
  Future<Either<Failure, String>> updateCart(CartTable cart);
  Future<Either<Failure, String>> removeCartById(int id);
  Future<Either<Failure, String>> removeAllCart();
  Future<bool> isAddedToCart(int id);
}
class CartRepositoryImpl extends CartRepository{
  final CartLocalDataSource cartLocalDataSource;

  CartRepositoryImpl(this.cartLocalDataSource);

  @override
  Future<Either<Failure, List<CartTable>>> getListCart() async{
    try{
      final result = await cartLocalDataSource.getListCart();
      return Right(result);
    }on DatabaseException catch(e){
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> insertCart(CartTable cart) async{
    try{
      final result = await cartLocalDataSource.insertCart(cart);
      return Right(result);
    }on DatabaseException catch(e){
      return Left(DatabaseFailure(e.message));
    }
  }


  @override
  Future<Either<Failure, String>> removeCartById(int id) async{
    try{
      final result = await cartLocalDataSource.removeById(id);
      return Right(result);
    }on DatabaseException catch(e){
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> updateCart(CartTable cart) async{
    try{
      final result = await cartLocalDataSource.updateCart(cart);
      return Right(result);
    }on DatabaseException catch(e){
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> removeAllCart() async{
    try{
      final result = await cartLocalDataSource.removeAllCart();
      return Right(result);
    }on DatabaseException catch(e){
      return Left(DatabaseFailure(e.message));
    }
  }

  //The method then checks if the result of the query is not null using a null check (result != null) and
  // returns a boolean value indicating whether the product was found (true) or not (false).
  @override
  Future<bool> isAddedToCart(int id) async{
    final result = await cartLocalDataSource.getCartById(id);
    return result != null;
  }

}