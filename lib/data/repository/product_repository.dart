import 'package:dartz/dartz.dart';
import 'package:shoes_app/data/datasource/remote/product_remote_data_source.dart';
import 'package:shoes_app/data/models/product_model.dart';
import 'package:shoes_app/utils/exception.dart';
import 'package:shoes_app/utils/failure.dart';

import '../models/category_model.dart';

abstract class ProductRepository{
  Future<Either<Failure, List<CategoryModel>>> getCategories();
  //returns a Future that resolves to an Either of Failure or a list of ProductModel.
  Future<Either<Failure, List<ProductModel>>> getProductByCategoriesId(int categoryId);

  //this one for detail page
  Future<Either<Failure, ProductModel>> getProductById(int id);
}

class ProductRepositoryImpl extends ProductRepository{
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<CategoryModel>>> getCategories() async{
    try{
      final result = await remoteDataSource.getCategories();
      return Right(result.data);
    }on ServerException catch(e){
      return Left(ServerFailure(e.message.toString()));
    }catch(e){
      return Left(ServerFailure(e.toString()));
    }
  }

  //this method returns an Either instance, indicating success or failure of the getProduct operation,
  // and it handles both expected and unexpected errors.
  @override
  Future<Either<Failure, List<ProductModel>>> getProductByCategoriesId(int categoryId) async{
    try{
      //It calls the remoteDataSource.getProductByCategoriesId() method, passing in the categoryId.
      //If the operation is successful, it returns a Right (List of Product model).
      final result = await remoteDataSource.getProductByCategoriesId(categoryId);
      return Right(result.data);

      //If the remoteDataSource.getProductByCategoriesId() call throws a ServerException, it catches the
      // exception and returns a Left instance wrapping a ServerFailure instance with an empty message.
    }on ServerException catch(e){
      return Left(ServerFailure(e.message.toString()));
    }catch(e){
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductModel>> getProductById(int id) async{
    try{
      final result = await remoteDataSource.getProductById(id);
      return Right(result);
    }on ServerException catch(e){
      return Left(ServerFailure(e.message.toString()));
    }catch(e){
      return Left(ServerFailure(e.toString()));
    }
  }

}