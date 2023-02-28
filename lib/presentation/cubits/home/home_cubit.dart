import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shoes_app/data/models/user_model.dart';

import '../../../data/models/catagory_model.dart';
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
        emit(HomeCategoriesLoaded(categories));
      },
    );
  }


}
