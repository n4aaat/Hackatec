import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const AuxiliaApp());
}

class AuxiliaApp extends StatelessWidget {
  const AuxiliaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AuxilIA',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF72C7D3)),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.first,
      routes: AppRoutes.routes,
    );
  }
}
