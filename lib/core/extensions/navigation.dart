import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension NavigationExtension on BuildContext {
  void navigateTo(String routeName, {Object? arguments}) {
    push(routeName, extra: arguments);
  }

  void navigateToReplacement(String routeName,  {Object? arguments}) {
    pushReplacement(routeName, extra: arguments);
  }

  void navigateToNamed(String routeName, {Object? arguments}) {
    pushNamed(routeName, extra: arguments);
  }

  void navigateToNamedReplacement(String routeName, {Object? arguments}) {
    go(routeName, extra: arguments);
  }

  void navigateBack() {
    pop();
  }
}
