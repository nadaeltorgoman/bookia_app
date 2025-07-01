import 'package:bookia/core/constants/app_constants.dart';
import 'package:bookia/core/services/dio_provider.dart';
import 'package:bookia/features/home/data/model/response/best_seller/best_seller.dart';
import 'package:bookia/features/home/data/model/response/slider_response/slider_response.dart';

class HomeRepo {
  static Future<SliderResponse?> getSlider() async {
    var response = await DioProvider.get(endPoint: AppConstants.sliderEP);
    try {
      if (response.statusCode == 200) {
        return SliderResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to load slider data');
      }
    } on Exception catch (_) {
      return null;
    }
  }

  static Future<BestSeller?> getBestSellers() async {
    var response = await DioProvider.get(endPoint: AppConstants.bestSellersEP);
    try {
      if (response.statusCode == 200) {
        return BestSeller.fromJson(response.data);
      } else {
        throw Exception('Failed to load best sellers data');
      }
    } on Exception catch (_) {
      return null;
    }
  }
}
