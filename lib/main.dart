import 'package:flutter/material.dart';
import 'core/di/injection.dart' as di;
import 'core/routing/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const String env = String.fromEnvironment('ENV', defaultValue: 'DEV');

    final Color primaryColor = env == 'PROD'
        ? const Color(0xFF001F3F)
        : Colors.teal;

    return MaterialApp.router(
      // Hubungkan GoRouter di sini
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          primary: primaryColor,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
        ),
        useMaterial3: true,
      ),
    );
  }
}
