import 'package:bookia/core/constants/app_constants.dart';
import 'package:bookia/core/services/cache_helper.dart';
import 'package:bookia/core/services/dio_provider.dart';
import 'package:bookia/features/wishList/data/model/wishlist_response/wishlist_response.dart';

class WishlistRepo {
  Future<WishListResponse?> getWishlist() async {
    var response = await DioProvider.get(
      endPoint: AppConstants.wishlistEP,
      headers: {'Authorization': 'Bearer ${SharedPref.getUserToken()}'},
    );
    try {
      if (response.statusCode == 200) {
        return WishListResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to load wishlist data');
      }
    } on Exception catch (_) {
      return null;
    }
  }

  static Future<bool> addToWishlist(int productId) async {
    var response = await DioProvider.post(
      endPoint: AppConstants.addToWishlistEP,
      data: {'product_id': productId},
      headers: {'Authorization': 'Bearer ${SharedPref.getUserToken()}'},
    );
    try {
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to add to wishlist');
      }
    } on Exception catch (_) {
      return false;
    }
  }

  static Future<WishListResponse?> removeFromWishlist(int productId) async {
    var response = await DioProvider.post(
      endPoint: AppConstants.removeFromWishlistEP,
      data: {'product_id': productId},
      headers: {'Authorization': 'Bearer ${SharedPref.getUserToken()}'},
    );
    try {
      if (response.statusCode == 200) {

        return WishListResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to remove from wishlist');
      }
    } on Exception catch (_) {
      return null;
    }
  }
}
