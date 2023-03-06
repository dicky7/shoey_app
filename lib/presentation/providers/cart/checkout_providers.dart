import 'package:flutter/cupertino.dart';
import 'package:shoes_app/data/models/checkout_order_model.dart';
import 'package:shoes_app/data/models/table/cart_table.dart';
import 'package:shoes_app/data/repository/transaction_repository.dart';
import 'package:shoes_app/utils/state_enum.dart';

import '../../../data/repository/cart_repository.dart';

class CheckoutProviders extends ChangeNotifier{
  final TransactionRepository transactionRepository;
  final CartRepository cartRepository;

  CheckoutProviders(this.transactionRepository, this.cartRepository);

  ResultState _state = ResultState.Initial;
  ResultState get state => _state;

  List<CartTable> _cartList = [];
  List<CartTable> get cartList => _cartList;

  int _totalPrice = 0;
  int get totalPrice => _totalPrice;

  int _totalItem = 0;
  int get totalItem => _totalItem;

  String _checkoutMessage = "";
  String get checkoutMessage => _checkoutMessage;


  //The purpose of this method is to set the list of items in the cart to a new value, provided as a parameter to the method.
  void setCartItems(List<CartTable> newCarts){
    //The method updates the _cartList variable with the new value,
    _cartList = newCarts;
    //calculates the total price of all items in the new cart, and updates the _totalPrice
    _totalPrice = cartList
        //The .map method is used to calculate the price of each item in the cart, by multiplying the price of each item with its quantity.
        // This results in a new list of prices for each item.
        .map((item) => item.price * item.quantity)
        //The .reduce method is then used to calculate the total price of all items in the cart by summing up all the prices in the list of prices obtained from the previous step.
        .reduce((value, element) => value + element)
        //Finally, the method updates the _totalPrice variable with the calculated value and convert it into interger
        .toInt();

    //calls the notifyListeners method to notify any listeners of the updated value.
    notifyListeners();
  }

  void getTotalItem(){
    _totalItem = cartList
        // the fold method to iterate over the list of objects and accumulate the total quantity using a lambda function.
        .fold(0,(value, element) => value + element.quantity);
    notifyListeners();
  }

  Future<void> checkoutOrder({
    required Function(String) onSuccess,
    required Function(String) onFailure}) async{
    _state = ResultState.Loading;
    notifyListeners();

    final items = cartList.map((cart) => CheckoutItems(
      quantity: cart.quantity,
      id: cart.id,
    )).toList();

    final bodyCheckoutOrder = CheckoutOrderModel(
        address: "Jakarta",
        shippingPrice: 15,
        items: items,
        status: "PENDING",
        totalPrice: totalPrice
    );

    final result = await transactionRepository.checkoutOrder(bodyCheckoutOrder);
    result.fold(
          (error) {
        _state = ResultState.Error;
        onFailure(error.message);
        notifyListeners();
      },
          (success) {
        _state = ResultState.Success;
        onSuccess("Sucess");
        notifyListeners();
      },
    );
  }

  Future<void> removeAllItem() async{
    final result = await cartRepository.removeAllCart();
    result.fold(
          (error){
        _state = ResultState.Error;
        notifyListeners();
      },
          (product) {
        _state = ResultState.Success;
        notifyListeners();
      },
    );
  }
}