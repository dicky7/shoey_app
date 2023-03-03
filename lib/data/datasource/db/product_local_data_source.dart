import 'package:shoes_app/data/datasource/db/database_helper.dart';
import 'package:shoes_app/data/models/product_model.dart';
import 'package:shoes_app/data/models/table/product_table.dart';
import 'package:shoes_app/utils/exception.dart';

import '../../../utils/constant.dart';

abstract class ProductLocalDataSource{
  Future<ProductTable?> getProductById(int id);
  Future<String> insertProductWishlist(ProductTable product);
  Future<String> removeProductById(int id);
  Future<List<ProductTable>> getWishlistProduct();
  Future<String> removeAllWishlist();
}

class ProductLocalDataSourceImpl extends ProductLocalDataSource{
  final DatabaseHelper databaseHelper;

  ProductLocalDataSourceImpl( this.databaseHelper);

  @override
  Future<ProductTable?> getProductById(int id) async{
    final result = await databaseHelper.getProductById(id);
    if (result.isNotEmpty) {
      return ProductTable.fromMap(result);
    }  else{
      return null;
    }
  }

  @override
  Future<String> insertProductWishlist(ProductTable product) async{
    try{
      await databaseHelper.insertWatchlist(product);
      return wishlistAddSuccessMessage;
    }catch (e){
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeProductById(int id) async{
    try{
      await databaseHelper.removeProductById(id);
      return wishlistRemoveSuccessMessage;
    } catch (e){
      throw DatabaseException(e.toString());
    }
  }

  // retrieves data from a database table using another function called getWatchlist(),
  // and then converts the returned list of maps into a list of ProductTable objects.
  @override
  Future<List<ProductTable>> getWishlistProduct() async{
    // retrieve the watchlist data from the database.
    final result = await databaseHelper.getWatchlist();

    //Then, the map() method is called on the result to convert each map object into a ProductTable object
    // using the ProductTable.fromMap() method. Finally, the toList() method is called to convert the resulting
    // Iterable of ProductTable objects into a List.
    return result.map((data) => ProductTable.fromMap(data)).toList();
  }

  @override
  Future<String> removeAllWishlist() async{
    try{
      await databaseHelper.removeAllProduct();
      return "Remove All Shoes Succefuly";
    }catch (e){
      throw DatabaseException(e.toString());
    }

  }

}