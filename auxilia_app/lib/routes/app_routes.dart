import 'package:flutter/material.dart';

// Importa tus páginas
import '../pages/login_page.dart';
import '../pages/register_page.dart';
import '../pages/dashboard_page.dart';
import '../pages/emergencia_page.dart';
import '../pages/resultado_page.dart';
import '../pages/decision_page.dart';
import '../pages/first.dart';
class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String dashboard = '/dashboard';
  static const String emergencia = '/emergencia';
  static const String resultado = '/resultado';
  static const String decision = '/decision';
  static const String first = '/first';

  static Map<String, WidgetBuilder> routes = {
    login: (context) => const LoginPage(),
    first: (context) => const First(),
    //register: (context) => const RegisterPage(),
    //dashboard: (context) => const DashboardPage(),
    //emergencia: (context) => const EmergenciaPage(),
    //resultado: (context) => const ResultadoPage(),
    //decision: (context) => const DecisionPage(),
  };
}
