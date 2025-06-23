import 'package:bookia/core/constants/app_constants.dart';
import 'package:bookia/core/services/dio_provider.dart';
import 'package:bookia/features/auth/data/model/request/register_params.dart';
import 'package:bookia/features/auth/data/model/response/user_response/user_response.dart';

class AuthRepo {
  static Future<UserResponse?> register(RegisterParams params) async {
    try {
      var response = await DioProvider.post(
        endPoint: AppConstants.registerEP,
        data: params.toJson(),
      );

      if (response.statusCode == 201) {
        return UserResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (_) {
      return null;
    }
  }

  static Future<UserResponse?> login(RegisterParams params) async {
    try {
      var response = await DioProvider.post(
        endPoint: AppConstants.loginEP,
        data: params.toJson(),
      );

      if (response.statusCode == 200) {
        return UserResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (_) {
      return null;
    }
  }

  static Future<UserResponse?> forgetPassword(RegisterParams params) async {
    try {
      var response = await DioProvider.post(
        endPoint: AppConstants.forgetPasswordEP,
        data: params.toJson(),
      );

      if (response.statusCode == 200) {
        return UserResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (_) {
      return null;
    }
  }
}
