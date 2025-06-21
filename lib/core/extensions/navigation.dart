import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension NavigationExtension on BuildContext {
  void navigateTo(String routeName) {
    push(routeName);
  }
  void navigateToReplacement(String routeName) {
    pushReplacement(routeName);
  }
  void navigateToNamed(String routeName, {Object? arguments}) {
    pushNamed(routeName, extra: arguments);
  }
  void navigateToNamedReplacement(String routeName, {Object? arguments}) {
    go(routeName, extra: arguments);
  }
}
