import 'package:bookia/core/constants/app_constants.dart';
import 'package:bookia/core/services/cache_helper.dart';
import 'package:bookia/core/services/dio_provider.dart';
import 'package:bookia/features/Cart/data/model/get_cart_response/get_cart_response.dart';
import 'package:bookia/features/Cart/data/model/update_cart_params.dart';

class CartRepo {
  Future<GetCartResponse?> getCart() async {
    var response = await DioProvider.get(
      endPoint: AppConstants.cartEP,
      headers: {'Authorization': 'Bearer ${SharedPref.getUserToken()}'},
    );
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        return GetCartResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to load Cart data');
      }
    } on Exception catch (_) {
      return null;
    }
  }

  static Future<bool> addToCart(int productId) async {
    var response = await DioProvider.post(
      endPoint: AppConstants.addToCartEP,
      data: {'product_id': productId},
      headers: {'Authorization': 'Bearer ${SharedPref.getUserToken()}'},
    );
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw Exception('Failed to add to Cart');
      }
    } on Exception catch (_) {
      return false;
    }
  }

  static Future<GetCartResponse?> removeFromCart(int cartItemId) async {
    var response = await DioProvider.post(
      endPoint: AppConstants.removeFromCartEP,
      data: {'cart_item_id': cartItemId},
      headers: {'Authorization': 'Bearer ${SharedPref.getUserToken()}'},
    );
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        return GetCartResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to remove from Cart');
      }
    } on Exception catch (_) {
      return null;
    }
  }

  static Future<GetCartResponse?> updateCart(UpdateCartParams params) async {
    var response = await DioProvider.post(
      endPoint: AppConstants.updateCartEP,
      data: params.toJson(),
      headers: {'Authorization': 'Bearer ${SharedPref.getUserToken()}'},
    );
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        return GetCartResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to update Cart');
      }
    } on Exception catch (_) {
      return null;
    }
  }

  static Future<bool> checkoutOrder() async {
    var response = await DioProvider.get(
      endPoint: AppConstants.checkoutEP,
      headers: {'Authorization': 'Bearer ${SharedPref.getUserToken()}'},
    );
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw Exception('Failed to clear Cart');
      }
    } on Exception catch (_) {
      return false;
    }
  }
}
