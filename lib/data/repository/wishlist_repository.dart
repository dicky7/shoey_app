import 'package:shoes_app/data/datasource/db/product_local_data_source.dart';
import 'package:shoes_app/data/models/product_model.dart';
import 'package:shoes_app/data/models/table/product_table.dart';
import 'package:shoes_app/utils/failure.dart';
import 'package:dartz/dartz.dart';

import '../../utils/exception.dart';

abstract class WishlistRepository{
  Future<bool> isAddedToWishlist(int id);
  Future<Either<Failure, List<ProductTable>>> getProductWishlist();
  Future<Either<Failure, String>> saveProductWishlist(ProductTable product);
  Future<Either<Failure, String>> removeWishlistById(int id);
  Future<Either<Failure, String>> removeAllWishlist();
}

class WishlistRepositoryImpl extends WishlistRepository{
  final ProductLocalDataSource productLocalDataSource;

  WishlistRepositoryImpl(this.productLocalDataSource);

  //The method then checks if the result of the query is not null using a null check (result != null) and
  // returns a boolean value indicating whether the product was found (true) or not (false).
  @override
  Future<bool> isAddedToWishlist(int id) async{
    final result = await productLocalDataSource.getProductById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, String>> saveProductWishlist(ProductTable product) async{
    try{
      final result = await productLocalDataSource.insertProductWishlist(product);
      return Right(result);
    }on DatabaseException catch(e){
      return Left(DatabaseFailure(e.message));
    }
  }


  @override
  Future<Either<Failure, String>> removeWishlistById(int id) async{
    try{
      final result = await productLocalDataSource.removeProductById(id);
      return Right(result);
    }on DatabaseException catch(e){
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<ProductTable>>> getProductWishlist() async{
    try{
      final result = await productLocalDataSource.getWishlistProduct();
      return Right(result);
    }on DatabaseException catch(e){
      return Left(DatabaseFailure(e.message));
    }
  }


  @override
  Future<Either<Failure, String>> removeAllWishlist() async{
    try{
      final result = await productLocalDataSource.removeAllWishlist();
      return Right(result);
    }on DatabaseException catch(e){
      return Left(DatabaseFailure(e.message));
    }

  }
}