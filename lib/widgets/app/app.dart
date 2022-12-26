import 'package:flutter/material.dart';
import 'package:mvvm/ui/navigation/main_navigation.dart';
import 'package:mvvm/widgets/app/app_model.dart';

class MyApp extends StatelessWidget {
  final MyAppModel model;
  static final mainNavigation = MainNavigation();
  const MyApp({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: mainNavigation.routes,
      initialRoute: mainNavigation.initialRoute(model.isAuth),
    );
  }
}
