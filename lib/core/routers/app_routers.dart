import 'package:bookia/features/auth/presentation/pages/login_screen.dart';
import 'package:bookia/features/auth/presentation/pages/register_screen.dart';
import 'package:bookia/features/intro/page/splash_screen.dart';
import 'package:bookia/features/intro/page/welcome_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouters {
  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String bookmark = '/bookmark';


  static final routers = GoRouter(routes: [
    GoRoute(
      path: splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: welcome,
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: register,
      builder: (context, state) => const RegisterScreen(),
    ),
  ]);
}