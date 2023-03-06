import 'package:flutter/cupertino.dart';
import 'package:shoes_app/data/models/product_model.dart';
import 'package:shoes_app/data/models/table/cart_table.dart';
import 'package:shoes_app/data/models/table/product_table.dart';
import 'package:shoes_app/data/repository/product_repository.dart';
import 'package:shoes_app/utils/state_enum.dart';

import '../../../data/repository/cart_repository.dart';
import '../../../data/repository/wishlist_repository.dart';

class DetailProductProviders extends ChangeNotifier{
  final ProductRepository productRepository;
  final WishlistRepository wishlistRepository;
  final CartRepository cartRepository;

  DetailProductProviders(this.productRepository, this.wishlistRepository, this.cartRepository);

  ResultState _state = ResultState.Initial;
  ResultState get state => _state;

  late ProductModel _product;
  ProductModel get product => _product;

  String _message = "";
  String get message => _message;

  //for wahctlist
  bool _isAddedToWishlist = false;
  bool get isAddedToWishlist => _isAddedToWishlist;

  String _wishlistMessage = "";
  String get wishlistMessage => _wishlistMessage;

  //add to cart
  String _cartMessage = "";
  String get cartMessage => _cartMessage;


  //this function to get detail product
  Future<void> getProductById(int idProduct)async{
    _state = ResultState.Loading;
    notifyListeners();

    final result = await productRepository.getProductById(idProduct);
    result.fold(
      (error) {
        _state = ResultState.Error;
        notifyListeners();
        return _message = error.message;
      },
      (product) {
        _state = ResultState.Success;
        notifyListeners();
        return _product = product;
      },
    );
  }

  // this method will check the product with the specified id has been added to the wishlist or not.
  // The result of the query is then assigned to the _isAddedToWishlist variable.
  Future<void> productWishlistStatus(int id) async{
    final result = await wishlistRepository.isAddedToWishlist(id);
    _isAddedToWishlist = result;
    notifyListeners();
  }

  //this method to add product to wishlist with productModel as an input
  Future<void> addToWishlist(ProductModel productModel) async {
    //this variable will convert data product model to productTable
    final bodyWishlish = ProductTable(
        id: productModel.id,
        name: productModel.name,
        price: productModel.price,
        photo: productModel.galleries[0].url);

    final result = await wishlistRepository.saveProductWishlist(bodyWishlish);
    result.fold(
      (error) => _wishlistMessage = error.message,
      (successMessage) {
        _wishlistMessage = successMessage;
      },
    );
    await productWishlistStatus(productModel.id);
  }

  Future<void> removeFromWishlist(int id) async{
    final result = await wishlistRepository.removeWishlistById(id);
    result.fold(
      (error) => _wishlistMessage = error.message,
      (successMessage) {
         _wishlistMessage = successMessage;
       }
    );
    await productWishlistStatus(id);
  }


  Future<void> addToCart(
      ProductModel product, {
        required void Function(String) onSuccess,
        required void Function(String) onFailure,
      }) async{

    final result = await cartRepository.isAddedToCart(product.id);
    result.fold(
      (error) => _cartMessage = error.message,
      (cart) async{
        if (cart != null) {
          final existingCart = cart.setUpdateCart(cart.quantity + 1);
          final result = await cartRepository.updateCart(existingCart);
          result.fold(
              (error) => onFailure(error.message),
              (success) => onSuccess(success)
          );
        }else{
          final bodyCart = CartTable(
              id: product.id,
              name: product.name,
              price: product.price,
              photo: product.galleries[0].url,
              quantity: 1
          );
          final result = await cartRepository.insertCart(bodyCart);
          result.fold(
              (error) => onFailure(error.message),
              (success) => onSuccess(success)
          );
        }
      },
    );
  }
}