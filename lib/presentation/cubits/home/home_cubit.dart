import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shoes_app/data/models/user_model.dart';

import '../../../data/models/catagory_model.dart';
import '../../../data/models/product_model.dart';
import '../../../data/repository/product_repository.dart';
import '../../../data/repository/user_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ProductRepository productRepository;

  HomeCubit(this.productRepository) : super(HomeInitial());

  Future<void> getCategories() async{
    emit(HomeLoading());
    final result = await productRepository.getCategories();
    result.fold(
      (error) => emit(HomeError(error.message)),
      (categories) {
        final popularShoes = CategoryModel(
            id: 0,
            name: "Popular",
            isSeledted: true
        );
        categories.insert(0, popularShoes);
        emit(HomePageLoaded(categories: categories));
      },
    );
  }

  Future<void> getProductsByCategory(int categoryId) async {
    emit(HomeLoading());

    final result = await productRepository.getProductByCategoriesId(categoryId);

    result.fold(
          (error) => emit(HomeError(productsCategoryMessage: error.message)),
          (products) => emit(HomePageLoaded(productsPerCategory: products)),
    );
  }

  Future<void> setCategorySelected(int selectedId) async {
    var previousSelected =
    state.categories.firstWhere((element) => element.isSelected);
    if (previousSelected != null) {
      state.categories = state.categories
          .map((category) => category.id == previousSelected.id
          ? category.setSelected(false)
          : category)
          .toList();
    }
    state.categories = state.categories
        .map((category) =>
    category.id == selectedId ? category.setSelected(true) : category)
        .toList();
    if (selectedId == 0) {
      state.categoryTitle = "Popular Products";
    } else {
      state.categoryTitle =
      "${state.categories.firstWhere((element) => element.id == selectedId).name} Products";
    }
    emit(HomePageCategorySelected());
    await getProductsByCategory(selectedId);
  }


}
