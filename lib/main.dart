import 'package:bookia/core/routers/app_routers.dart';
import 'package:bookia/core/services/cache_helper.dart';
import 'package:bookia/core/services/dio_provider.dart';
import 'package:bookia/core/utils/app_theme.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioProvider.init();
  await SharedPref.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.lightTheme(),
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouters.routers,
    );
  }
}
