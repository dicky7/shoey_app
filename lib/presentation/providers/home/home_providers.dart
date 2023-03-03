import 'package:flutter/cupertino.dart';
import 'package:shoes_app/data/models/category_model.dart';
import 'package:shoes_app/data/models/user_model.dart';
import 'package:shoes_app/data/repository/user_repository.dart';
import 'package:shoes_app/utils/state_enum.dart';

import '../../../data/models/product_model.dart';
import '../../../data/repository/product_repository.dart';

class HomeProviders extends ChangeNotifier{
  final UserRepository userRepository;
  final ProductRepository productRepository;


  //we calls to _getCategories() inside the cosntructor because when an instance of HomeProviders is created,
  // we want _getCategories() get called/initiliaze too. so we don't need initiliaze the function in page screen.
  HomeProviders(this.userRepository, this.productRepository){
   _getCategories();
  }

  //note! (1 state for 1 function)
  // each function must have their own state and message, with 1 state on 1 function make app not confused
  ResultState _stateUser = ResultState.Initial;
  ResultState get stateUser => _stateUser;

  ResultState _stateCategory = ResultState.Initial;
  ResultState get stateCategory => _stateCategory;

  ResultState _stateProductByCatagory = ResultState.Initial;
  ResultState get stateProductByCatagory => _stateProductByCatagory;

  late UserModel _userModel;
  UserModel get userModel => _userModel;

  List<CategoryModel> _categoryList = [];
  List<CategoryModel> get categoryList => _categoryList;

  List<ProductModel> _productListCategory = [];
  List<ProductModel> get productListCategory => _productListCategory;

  String _messageUser = "";
  String get messageUser => _messageUser;

  String _messageCatagory = "";
  String get messageCatagory => _messageCatagory;

  String _messageProductByCatagory = "";
  String get messageProductByCatagory => _messageProductByCatagory;

  String _catagoryTitle = "Category Popular";
  String get catagoryTitle => _catagoryTitle;


  Future<void> getUserProfile() async{
    _stateUser = ResultState.Loading;
    notifyListeners();

    final result = await userRepository.getUser();
    result.fold(
      (error) {
        _stateUser = ResultState.Error;
        notifyListeners();
        return _messageUser = error.message;
      },
      (user) {
        _stateUser = ResultState.Success;
        notifyListeners();
        return _userModel = user;
      },
    );
  }

  //we make function private with add undescore and this function only can be access inside the class
  Future<void> _getCategories() async{
    //initial state from initial to loading
    //and notifyListeners() used to notify any listeners that the state of the object
    _stateCategory = ResultState.Loading;
    notifyListeners();

    final result = await productRepository.getCategories();
    result.fold(
      //If result.fold() returns an error (Left), it sets the state of _state to ResultState.Error,
      // calls notifyListeners(), and sets the value of _message to the error's message.
      (error) {
        _stateCategory = ResultState.Error;
        notifyListeners();
        return _messageCatagory = error.message;
      },
      //If result.fold() returns success (Right), it sets the state of _state to ResultState.Success,
      // and calls notifyListeners(). sets the value of _categoryModel to _category(List<Category>).
      (category) {
        final popularShoesCategory = CategoryModel(
          id: 0,
          name: 'Popular',
          isSelected: true,
        );
        _categoryList = category;
        _categoryList.insert(0, popularShoesCategory);
        _stateCategory = ResultState.Success;
        notifyListeners();
        return _categoryList = category;
      },
    );
  }


  //When the user selects a new category, this method updates the state of the app accordingly,
// updates the UI, and fetches the products for the new category.
  Future<void> setSelectedCategory(int selectedId) async{
    //finds the previous selected category from the _categories list using the firstWhere()
    // method and saves it to previousSelected.
    final previusSelected = _categoryList.firstWhere((element) => element.isSelected);

    //If there was a previously selected category, unselects it by calling the setSelected()
    // method with false and updates the _categories list.
    if (previusSelected != null) {
      _categoryList = _categoryList.map((category) => category.id == previusSelected.id
            ? category.setSelected(false)
            : category).toList();
    }
    //selects the new category by calling the setSelected() method with true and updates the _categories list.
    _categoryList = _categoryList.map((category) => category.id == selectedId
        ? category.setSelected(true)
        : category).toList();
    
    // sets _categoryTitle to the name of the selected category followed by "Products".
    _catagoryTitle = "Category ${_categoryList.firstWhere((category) => category.id == selectedId).name}";

    notifyListeners();
    //calls the getProductsByCategory method with the selectedId parameter to retrieve products in the selected category.
    await getProductByCategory(selectedId);
  }

  //this function will fetch list of product by category id;
  Future<void> getProductByCategory(int categoryId) async{
    _stateProductByCatagory = ResultState.Loading;
    notifyListeners();

    final result = await productRepository.getProductByCategoriesId(categoryId);
    result.fold(
      (error) {
        _stateProductByCatagory = ResultState.Error;
        notifyListeners();
        return _messageProductByCatagory = error.message;
      },
      (product) {
        if(product.isNotEmpty){
          _stateProductByCatagory = ResultState.Success;
          notifyListeners();
          return _productListCategory = product;
        }else{
          _stateProductByCatagory = ResultState.Empty;
          notifyListeners();
          return _messageProductByCatagory = "Shoe Not Found";
        }
      },
    );
  }


}