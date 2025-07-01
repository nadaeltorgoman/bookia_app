import 'package:bookia/features/auth/presentation/pages/forget_password_screen.dart';
import 'package:bookia/features/auth/presentation/pages/login_screen.dart';
import 'package:bookia/features/auth/presentation/pages/new_password_screen.dart';
import 'package:bookia/features/auth/presentation/pages/otp_verification_screen.dart';
import 'package:bookia/features/auth/presentation/pages/register_screen.dart';
import 'package:bookia/features/auth/presentation/pages/success_screen.dart';
import 'package:bookia/features/home/data/model/response/best_seller/product.dart';
import 'package:bookia/features/home/presentation/pages/book_details_screen.dart';
import 'package:bookia/features/intro/page/splash_screen.dart';
import 'package:bookia/features/intro/page/welcome_screen.dart';
import 'package:bookia/features/main/presentation/pages/main_app_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouters {
  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgetPassword = '/forget-password';
  static const String otpVerification = '/otp-verification';
  static const String newPassword = '/new-password';
  static const String success = '/success';
  static const String main = '/main';
  static const String bookDetails = '/book-details';

  static final routers = GoRouter(
    routes: [
      GoRoute(path: splash, builder: (context, state) => const SplashScreen()),
      GoRoute(
        path: welcome,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(path: login, builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: forgetPassword,
        builder: (context, state) => const ForgetPasswordScreen(),
      ),
      GoRoute(
        path: otpVerification,
        builder:
            (context, state) =>
                OTPVerificationScreen(email: state.extra as String?),
      ),
      GoRoute(
        path: newPassword,
        builder:
            (context, state) =>
                NewPasswordScreen(verifiedCode: state.extra as int?),
      ),
      GoRoute(
        path: success,
        builder: (context, state) => const SuccessScreen(),
      ),
      GoRoute(path: main, builder: (context, state) => const MainAppScreen()),
      GoRoute(
        path: bookDetails,
        builder:
            (context, state) => BookDetailsScreen(book: state.extra as Product),
      ),
    ],
  );
}
