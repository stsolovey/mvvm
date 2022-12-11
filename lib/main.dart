import 'package:flutter/material.dart';
import 'package:mvvm/widgets/app/app_model.dart';
import 'widgets/app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final model = MyAppModel();
  await model.checkAuth();
  final app = MyApp(model: model);
  runApp(app);
}
