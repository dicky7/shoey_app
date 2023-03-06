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

  //delete message
  String _removeMessage = "";
  String get removeMessage => _removeMessage;

  int _totalPrice = 0;
  int get totalPrice => _totalPrice;

  Future<void> getCartList() async{
    final result = await cartRepository.getListCart();
    result.fold(
      (error){
        _state = ResultState.Error;
        notifyListeners();
        return _message = error.message;
      },
      (product) {
        _cartList = product;
        _state = ResultState.Success;
        getTotalPrice();
        notifyListeners();
      },
    );
  }

  Future<void> removeCartItem(int id) async{
    final result = await cartRepository.removeCartById(id);
    result.fold(
      (error) => _removeMessage = error.message,
      (successMessage) {
        //searches for the selected product using the firstWhere method, which returns the first element of _cartItem that matches the given id.
        final selectedCart = _cartList.firstWhere((cartItem) => cartItem.id == id);
        //The selected product is then removed from _cartProduct using the remove method.
        _cartList.remove(selectedCart);
        _removeMessage = successMessage;

        //call getTotal price so when item remove from the cart it will update the price too
        getTotalPrice();

        notifyListeners();
      },
    );
  }



  Future<void> decreaseCartItem(CartTable cart) async {
    //The method first checks if the quantity of the provided cart object is already 1. If it is, it removes the item from the cart by calling
    // the removeCartItem method.
    if (cart.quantity == 1) {
      await removeCartItem(cart.id);
    } else {
     // If the quantity is greater than 1, it creates a new CartTable object with the updated quantity by calling the setUpdateCart method
      // and passing the updated quantity as an argument.
      final updateCart = cart.setUpdateCart(cart.quantity - 1);

      //After that, the code calls the updateCart method on the cartRepository object with the updated CartTable object.
      final result = await cartRepository.updateCart(updateCart);
      result.fold(
        (error) => _message = error.message,
        (updated) {
          // If the update is successful, the code updates the local _cartList variable to reflect the updated CartTable object
          _cartList = cartList.map((item) => item.id == cart.id
              ? cart.setUpdateCart(updateCart.quantity)
              : item).toList();

          //call getTotal price so when item cart decreased it will update the price too
          getTotalPrice();

          //then calls the notifyListeners method to notify any listeners of this change.
          notifyListeners();
        },
      );
    }
  }

  Future<void> increaseCartItem(CartTable cartTable) async {
    //The method first creates a new CartTable object with the updated quantity by calling the setUpdateCart method and passing the updated quantity as an argument.
    final updateCart = cartTable.setUpdateCart(cartTable.quantity + 1);

    //After that, the code calls the updateCart method on the cartRepository object with the updated CartTable object.
    final result = await cartRepository.updateCart(updateCart);
    result.fold(
       (error) => _message = error.message,
       (updated) {
         //the code updates the local _cartList variable to reflect the updated CartTable object
         //The map method applies a given function to each item in the list and returns a new list containing the results.
         // the function being applied is an anonymous function that takes an item as an argument and checks if its ID matches the ID of the cartTable
         // object that was passed to the method.  If the IDs match, the function returns a new CartTable object with the updated quantity (which was calculated
         // earlier by calling the setUpdateCart method on the cartTable object). If the IDs do not match, the function simply returns the original item.
         _cartList = _cartList.map((item) => item.id == cartTable.id
            ? cartTable.setUpdateCart(updateCart.quantity)
            : item).toList();

         //call getTotal price so when item cart increased it will update the price too
         getTotalPrice();

         // then calls the notifyListeners method to notify any listeners of this change.
         notifyListeners();
      },
    );
  }

  //The method retrieves the list of items in the cart, which is stored in the _cartList variable, and method calculates the total price of all items
  void getTotalPrice(){
    if(_cartList.isNotEmpty){
      _totalPrice = cartList
      //The .map method is used to calculate the price of each item in the cart, by multiplying the price of each item with its quantity.
      // This results in a new list of prices for each item.
          .map((item) => item.price * item.quantity)
      //The .reduce method is then used to calculate the total price of all items in the cart by summing up all the prices in the list of prices obtained from the previous step.
          .reduce((value, element) => value + element)
          .toInt();
      //Finally, the method updates the _totalPrice variable with the calculated value
    }
    //calls the notifyListeners method to notify any listeners of the updated value.
    notifyListeners();
  }

  Future<void> removeAllItem({
    required Function(String) onSuccess,
    required Function(String) onFailure}) async{
    final result = await cartRepository.removeAllCart();
    result.fold(
          (error){
        _state = ResultState.Error;
        onFailure(error.message);
        notifyListeners();
      },
          (product) {
        _state = ResultState.Success;
        onSuccess("Success");
        notifyListeners();
      },
    );
  }
}


