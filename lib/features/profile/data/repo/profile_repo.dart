import 'package:bookia/core/constants/app_constants.dart';
import 'package:bookia/core/services/cache_helper.dart';
import 'package:bookia/core/services/dio_provider.dart';

class ProfileRepo {
  static Future<bool> logout() async {
    try {
      var response = await DioProvider.post(
        endPoint: AppConstants.logoutEP,
        headers: {'Authorization': 'Bearer ${SharedPref.getUserToken()}'},
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (_) {
      return false;
    }
  }
}
