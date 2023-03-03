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
    //The method first checks if the quantity of the provided cart object is already 1. If it is,
    // it removes the item from the cart by calling the removeCartItem method.
    if (cart.quantity == 1) {
      await removeCartItem(cart.id);
    } else {
     // If the quantity is greater than 1, it creates a new CartTable object with the updated quantity by
      // calling the setUpdateCart method and passing the updated quantity as an argument.
      final updateCart = cart.setUpdateCart(cart.quantity - 1);

      //After that, the code calls the updateCart method on the cartRepository object with the updated CartTable object.
      final result = await cartRepository.updateCart(updateCart);
      result.fold(
        (error) => _message = error.message,
        (updated) {
          // If the update is successful, the code updates the local _cartList variable to reflect the updated
          // CartTable object
          _cartList = cartList.map((item) => item.id == cart.id
              ? cart.setUpdateCart(updateCart.quantity)
              : item).toList();

          //then calls the notifyListeners method to notify any listeners of this change.
          notifyListeners();
        },
      );
    }
  }

  Future<void> increaseCartItem(CartTable cartTable) async {
    //The method first creates a new CartTable object with the updated quantity by calling the setUpdateCart
    // method and passing the updated quantity as an argument.
    final updateCart = cartTable.setUpdateCart(cartTable.quantity + 1);

    //After that, the code calls the updateCart method on the cartRepository object with the updated CartTable object.
    final result = await cartRepository.updateCart(updateCart);
    result.fold(
       (error) => _message = error.message,
       (updated) {
         //If the update is successful, the code updates the local _cartList variable to reflect the updated CartTable object
         _cartList = _cartList.map((item) => item.id == cartTable.id
            ? cartTable.setUpdateCart(updateCart.quantity)
            : item).toList();

         // then calls the notifyListeners method to notify any listeners of this change.
         notifyListeners();
      },
    );
  }
}


