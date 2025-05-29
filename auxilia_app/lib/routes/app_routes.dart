import 'package:flutter/material.dart';

// Importa tus páginas
import '../pages/login_page.dart';
import '../pages/first.dart';
import 'package:auxilia_app/prueba.dart';

class AppRoutes {
  static const String login = '/login';
  static const String first = '/first';
  static const String prueba = '/prueba';

  static Map<String, WidgetBuilder> routes = {
    login: (context) => const LoginPage(),
    first: (context) => const First(),
    prueba: (context) => const Prueba(),
  };
}
