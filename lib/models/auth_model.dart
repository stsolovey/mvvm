import 'package:flutter/cupertino.dart';
import 'package:mvvm/domain/api_cilent/api_cilent.dart';

class AuthModel extends ChangeNotifier {
  final _apiClient = ApiClient();

  final loginTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isAuthProgress = false;
  bool get canStartAuth => !_isAuthProgress;

  Future<void> auth(BuildContext context) async {
     final login = loginTextController.text;
     final password = passwordTextController.text;
     if (login.isEmpty || password.isEmpty){
       _errorMessage = 'Заполните логин и пароль';
       notifyListeners();
       return;
     }
     _errorMessage = null;
     _isAuthProgress = true;
     notifyListeners();
     final token = await _apiClient.login(
        login: login, 
        password: password
     );
     _isAuthProgress = false;
     notifyListeners();
     print(token);
  }
}

class AuthProvider extends InheritedNotifier {
  final AuthModel model;
  const AuthProvider({
  super.key, 
  required this.model, 
  required this.child
}) : super(
  notifier: model, 
  child: child
  );

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