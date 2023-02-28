part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}
class HomeLoading extends HomeState {}

class HomePageLoaded extends HomeState {
  final List<CategoryModel>? categories;
  final List<ProductModel>? productsPerCategory;
  final String? categoryTitle;

  HomePageLoaded({
    this.categories,
    this.productsPerCategory,
    this.categoryTitle
  });

  @override
  List<Object?> get props => [
    categories,
    productsPerCategory,
    categoryTitle
  ];
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);

  @override
  // TODO: implement props
  List<Object> get props => [message];
}