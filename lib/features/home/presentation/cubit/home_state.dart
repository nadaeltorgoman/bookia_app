class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {}

class HomeError extends HomeState {}

class AddedToWishList extends HomeState {
  final String message;

  AddedToWishList({required this.message});
}
