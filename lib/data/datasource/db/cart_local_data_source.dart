import 'package:shoes_app/data/datasource/db/cart_database_helper.dart';
import 'package:shoes_app/data/models/table/cart_table.dart';
import 'package:shoes_app/utils/exception.dart';

import '../../../utils/constant.dart';

abstract class CartLocalDataSource{
  Future<List<CartTable>> getListCart();
  Future<String> insertCart(CartTable cart);
  Future<CartTable?> getCartById(int id);
  Future<String> removeById(int id);
  Future<String> updateCart(CartTable cart);
  Future<String> removeAllCart();
}

class CartLocalDataSourceImpl extends CartLocalDataSource{
  final CartDatabaseHelper cartDatabaseHelper;

  CartLocalDataSourceImpl(this.cartDatabaseHelper);

  @override
  Future<List<CartTable>> getListCart() async{
    // retrieve the cart data from the database.
    final result = await cartDatabaseHelper.getListCart();

    //Then, the map() method is called on the result to convert each map object into a ProductTable object
    // using the ProductTable.fromMap() method. Finally, the toList() method is called to convert the resulting
    // Iterable of ProductTable objects into a List.
    return result.map((data) => CartTable.fromMap(data)).toList();
  }

  @override
  Future<String> insertCart(CartTable cart) async{
    try{
      await cartDatabaseHelper.insertCart(cart);
      return cartAddSuccessMessage;
    }catch(e){
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<CartTable?> getCartById(int id) async{
    final result = await cartDatabaseHelper.getCartById(id);
    if (result.isNotEmpty) {
      return CartTable.fromMap(result);
    }else{
      return null;
    }
  }

  @override
  Future<String> removeById(int id) async{
    try{
      await cartDatabaseHelper.removeCartById(id);
      return cartRemoveSuccessMessage;
    }catch (e){
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> updateCart(CartTable cart) async{
    try{
      await cartDatabaseHelper.updateCart(cart);
      return cartUpdateSuccessMessage;
    }catch (e){
      throw DatabaseException(e.toString());
    }
  }


  @override
  Future<String> removeAllCart() async{
    try{
      await cartDatabaseHelper.removeAllCart();
      return "Remove All Cart";
    }catch (e){
      throw DatabaseException(e.toString());
    }
  }




}

