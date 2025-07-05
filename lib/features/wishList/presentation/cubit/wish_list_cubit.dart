import 'package:bookia/features/Cart/data/repo/cart_repo.dart';
import 'package:bookia/features/wishList/data/model/wishlist_response/wishlist_response.dart';
import 'package:bookia/features/wishList/data/repo/wishlist_repo.dart';
import 'package:bookia/features/wishList/presentation/cubit/wish_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishListCubit extends Cubit<WishListState> {
  WishListCubit() : super(WishListInitial());
  WishListResponse? wishListResponse = WishListResponse();

  Future<void> getWishListData() async {
    emit(WishListLoading());
    try {
      var response = await WishlistRepo().getWishlist();
      if (response != null) {
        wishListResponse = response;
        emit(WishListLoaded());
      } else {
        emit(WishListError());
      }
    } catch (_) {
      emit(WishListError());
    }
  }

  Future<void> addToCart(int productId) async {
    emit(WishListLoading());
    try {
      var response = await CartRepo.addToCart(productId);
      if (response) {
        emit(AddedToCartSuccessfully());
      } else {
        emit(WishListError());
      }
    } catch (_) {
      emit(WishListError());
    }
  }

  Future<void> removeFromWishList(int productId) async {
    emit(RemoveFromWishListLoading());
    try {
      var response = await WishlistRepo.removeFromWishlist(productId);
      if (response != null) {
        wishListResponse = response;
        emit(WishListItemRemovedSuccessfully());
      } else {
        emit(WishListError());
      }
    } catch (_) {
      emit(WishListError());
    }
  }
}
