part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}
class HomeLoading extends HomeState {}
class HomeError extends HomeState {
  final String message;

  HomeError(this.message);

  @override
  // TODO: implement props
  List<Object> get props => [message];
}

class HomeCategoriesLoaded extends HomeState {
  final List<CategoryModel> categories;

  const HomeCategoriesLoaded(this.categories);

  @override
  // TODO: implement props
  List<Object> get props => [categories];
}
