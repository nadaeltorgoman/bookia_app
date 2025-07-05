class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {}

class CartError extends CartState {
  final String message;

  CartError({required this.message});
}

class RemoveFromCartLoading extends CartState {}

class CartItemRemovedSuccessfully extends CartState {}

class UpdateCartLoading extends CartState {}

class CartUpdatedSuccessfully extends CartState {}

class CheckoutLoading extends CartState {}

class CheckoutSuccess extends CartState {}
