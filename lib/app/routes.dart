import 'package:estudos/app/views/home/home_page.dart';
import 'package:estudos/app/views/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  // ignore: constant_identifier_names
  static const String ROTA_HOME = "/home";

  static Route<MaterialPageRoute> generatorRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case ROTA_HOME:
        return MaterialPageRoute(builder: (_) => const HomePage());

      default:
        return MaterialPageRoute(builder: (_) => const HomePage());
    }
  }
}
