import 'package:flutter/material.dart';
import 'package:mvvm/models/auth_model.dart';
import 'package:mvvm/widgets/auth/auth_widget.dart';
import 'package:mvvm/widgets/main_screen/main_screen_widget.dart';

class MainNavigationRouteNames {
  static const auth = 'auth';
  static const mainScreen = '/';
  static const courses = '/courses';
}

class MainNavigation {
  String initialRoute(bool isAuth) => isAuth
      ? MainNavigationRouteNames.mainScreen
      : MainNavigationRouteNames.auth;
  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteNames.auth: (context) =>
        AuthProvider(model: AuthModel(), child: const AuthWidget()),
    MainNavigationRouteNames.mainScreen: (context) => const MainScreenWidget(),
    MainNavigationRouteNames.courses: (context) => const MainScreenWidget(),
  };
}
