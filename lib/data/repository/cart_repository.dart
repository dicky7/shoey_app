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
  Future<Either<Failure, CartTable?>> isAddedToCart(int id);
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

  //the method  checks whether a product with a specific ID is already added to a shopping cart.
  @override
  Future<Either<Failure, CartTable?>> isAddedToCart(int id) async{
    try{
      //in cartLocalDataSource The method then checks whether the retrieved result is not null using a null check (result != null).
      final result = await cartLocalDataSource.getCartById(id);
      //If the result is not null, the method returns a Right value containing the retrieved CartTable object,
      // indicating that the product is already added to the cart.
      return Right(result);

    }on DatabaseException catch(e){
      return Left(DatabaseFailure(e.message));
    }
  }

}