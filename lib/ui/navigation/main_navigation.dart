import 'package:flutter/material.dart';
import 'package:mvvm/models/auth_model.dart';
import 'package:mvvm/widgets/auth/auth_widget.dart';
import 'package:mvvm/widgets/main_screen/main_screen_widget.dart';

class MainNavigationRouteNames {
  static const auth = '/auth';
  static const mainScreen = '/main_screen';
  static const movidDetails = '/courses';
}

class MainNavigation {
  String initialRoute(bool isAuth) => isAuth
      ? MainNavigationRouteNames.mainScreen
      : MainNavigationRouteNames.auth;
  final routes = <String, Widget Function(BuildContext)>{
    '/auth': (context) =>
        AuthProvider(model: AuthModel(), child: const AuthWidget()),
    '/main_screen': (context) => const MainScreenWidget(),
  };
}
