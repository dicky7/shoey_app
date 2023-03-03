import 'package:flutter/cupertino.dart';
import 'package:shoes_app/data/repository/cart_repository.dart';
import 'package:shoes_app/utils/state_enum.dart';

import '../../../data/models/table/cart_table.dart';

class CartProviders extends ChangeNotifier{
  final CartRepository cartRepository;

  CartProviders(this.cartRepository);

  ResultState _state = ResultState.Initial;
  ResultState get state => _state;

  List<CartTable> _cartList = [];
  List<CartTable> get cartList => _cartList;

  String _message = "";
  String get message => _message;

  //add and delete
  String _removeMessage = "";
  String get removeMessage => _removeMessage;


  Future<void> getCartList() async{
    final result = await cartRepository.getListCart();
    result.fold(
      (error){
        _state = ResultState.Error;
        notifyListeners();
        return _message = error.message;
      },
      (product) {
        _state = ResultState.Success;
        notifyListeners();
        return _cartList = product;
      },
    );
  }

  Future<void> removeCartItem(int id) async{
    final result = await cartRepository.removeCartById(id);
    result.fold(
      (error) => _removeMessage = error.message,
      (successMessage) {
        //searches for the selected product using the firstWhere method, which returns the first element
        // of _cartItem that matches the given id.
        final selectedCart = _cartList.firstWhere((cartItem) => cartItem.id == id);
        //The selected product is then removed from _cartProduct using the remove method.
        _cartList.remove(selectedCart);
        _removeMessage = successMessage;
        notifyListeners();
      },
    );
  }

  Future<void> decreaseCartItem(CartTable cart) async {
    if (cart.quantity == 1) {
      await removeCartItem(cart.id);
    } else {
      final updateCart = cart.setUpdateCart(cart.quantity - 1);
      final result = await cartRepository.updateCart(updateCart);
      result.fold(
        (error) => _message = error.message,
        (updated) {
          _cartList = cartList.map((item) => item.id == cart.id
              ? cart.setUpdateCart(updateCart.quantity)
              : item).toList();
          notifyListeners();
        },
      );
    }
  }

  Future<void> increaseCartItem(CartTable cartTable) async {
    final updateCart = cartTable.setUpdateCart(cartTable.quantity + 1);
    final result = await cartRepository.updateCart(updateCart);
    result.fold(
       (error) => _message = error.message,
       (updated) {
         _cartList = _cartList.map((item) => item.id == cartTable.id
            ? cartTable.setUpdateCart(updateCart.quantity)
            : item).toList();
         notifyListeners();
      },
    );
  }
}


