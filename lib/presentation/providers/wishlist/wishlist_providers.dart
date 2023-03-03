import 'package:flutter/cupertino.dart';
import 'package:shoes_app/data/models/table/product_table.dart';
import 'package:shoes_app/data/repository/wishlist_repository.dart';
import 'package:shoes_app/utils/state_enum.dart';

class WishlistProviders extends ChangeNotifier{
  final WishlistRepository wishlistRepository;

  WishlistProviders(this.wishlistRepository);

  ResultState _state = ResultState.Initial;
  ResultState get state => _state;

  List<ProductTable> _wishlistProduct = [];
  List<ProductTable> get wishlistProduct => _wishlistProduct;

  String _message = "";
  String get message => _message;

  bool _isAddedToWishlist = false;
  bool get isAddedToWishlist => _isAddedToWishlist;

  String _wishlistMessage = "";
  String get wishlistMessage => _wishlistMessage;

  Future<void> getWishlistShoes() async{
    final result = await wishlistRepository.getProductWishlist();
    result.fold(
      (error){
        _state = ResultState.Error;
        notifyListeners();
        return _message = error.message;
      },
      (product) {
        _state = ResultState.Success;
        notifyListeners();
        return _wishlistProduct = product;
      },
    );
  }


  Future<void> removeWishlist(int id) async{
    final result = await  wishlistRepository.removeWishlistById(id);
    result.fold(
      (error) => _wishlistMessage = error.message,
      (successMessage) {
        //searches for the selected product using the firstWhere method, which returns the first element
        // of _wishlistProduct that matches the given id.
        final selected = _wishlistProduct.firstWhere((item) => item.id == id);
        //The selected product is then removed from _wishlistProduct using the remove method.
        _wishlistProduct.remove(selected);
        _wishlistMessage = successMessage;
        notifyListeners();
      },
    );
  }
}