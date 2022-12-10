import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mvvm/domain/api_cilent/api_cilent.dart';
import 'package:mvvm/domain/data_providers/token_data_provider.dart';
import 'package:mvvm/ui/navigation/main_navigation.dart';

class AuthModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final _tokenDataProvider = TokenDataProvider();

  final loginTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isAuthProgress = false;
  bool get canStartAuth => !_isAuthProgress;
  bool get isAuthProgress => _isAuthProgress;

  Future<void> auth(BuildContext context) async {
    final login = loginTextController.text;
    final password = passwordTextController.text;
    if (login.isEmpty || password.isEmpty) {
      _errorMessage = 'Заполните логин и пароль';
      notifyListeners();
      return;
    }
    _errorMessage = null;
    _isAuthProgress = true;
    print('canStartAuth: $canStartAuth');
    notifyListeners();
    //final token = await _apiClient.login(login: login, password: password);
    String? token;
    try {
      final json = await _apiClient.login(login: login, password: password);
      if (json['status']) {
        token = json['token'];
      } else {
        _errorMessage = "Неправильный логин или пароль!";
      }

      //print('status: ${json["status"]}');
      //print("json['status'] == true: ${json['status'] == true}");
      //print("token: ${json['token']}");
    } catch (e) {
      //print("error");
      //print(e);
      _errorMessage = "Ошибка!";
    }

    _isAuthProgress = false;
    if (_errorMessage != null) {
      notifyListeners();
      return;
    }

    if (token == null) {
      notifyListeners();
      return;
    }

    await _tokenDataProvider.setToken(token);

    unawaited(
        Navigator.of(context).pushNamed(MainNavigationRouteNames.mainScreen));
  }
}

class AuthProvider extends InheritedNotifier {
  final AuthModel model;
  const AuthProvider({super.key, required this.model, required this.child})
      : super(notifier: model, child: child);

  final Widget child;

  static AuthProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AuthProvider>();
  }

  static AuthProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AuthProvider>();
  }

  static AuthProvider? read(BuildContext context) {
    final widget =
        context.getElementForInheritedWidgetOfExactType<AuthProvider>()?.widget;
    return widget is AuthProvider ? widget : null;
  }
}
