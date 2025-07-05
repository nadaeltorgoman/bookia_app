import 'package:bookia/features/Cart/data/repo/cart_repo.dart';
import 'package:bookia/features/home/data/model/response/best_seller/best_seller.dart';
import 'package:bookia/features/home/data/model/response/best_seller/product.dart';
import 'package:bookia/features/home/data/model/response/slider_response/slider.dart';
import 'package:bookia/features/home/data/model/response/slider_response/slider_response.dart';
import 'package:bookia/features/home/data/repo/home_repo.dart';
import 'package:bookia/features/home/presentation/cubit/home_state.dart';
import 'package:bookia/features/wishList/data/repo/wishlist_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  List<SliderModel> sliders = [];
  List<Product> bestSellers = [];

  getHomeData() async {
    emit(HomeLoading());
    // call 2 apis in parallel
    try {
      var futures = await Future.value([
        HomeRepo.getSlider(),
        HomeRepo.getBestSellers(),
      ]);

      sliders = ((await futures[0]) as SliderResponse).data?.sliders ?? [];
      bestSellers = ((await futures[1]) as BestSeller).data?.products ?? [];
      emit(HomeLoaded());
    } on Exception catch (_) {
      emit(HomeError());
    }
  }

  Future<void> addToWishList(int productId) async {
    emit(HomeLoading());
    try {
      var response = await WishlistRepo.addToWishlist(productId);
      if (response) {
        emit(AddedToWishList(message: "Added to wishlist successfully"));
      } else {
        emit(HomeError());
      }
    } on Exception catch (_) {
      emit(HomeError());
    }
  }

  
  Future<void> addToCart(int productId) async {
    emit(HomeLoading());
    try {
      var response = await CartRepo.addToCart(productId);
      if (response) {
        emit(AddedToWishList(message: "Added to cart successfully"));
      } else {
        emit(HomeError());
      }
    } catch (_) {
      emit(HomeError());
    }
  }
}
