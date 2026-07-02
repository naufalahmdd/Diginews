import 'package:flutter/material.dart';
import 'features/home/presentation/pages/main_page.dart'; // Import MainPage kamu

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Membaca variable ENV dari dart-define (Default ke DEV jika tidak diisi)
    const String env = String.fromEnvironment('ENV', defaultValue: 'DEV');

    // TANTANGAN ANTI-AI: Atur tema warna dasar berdasarkan environment [cite: 26, 27]
    final Color primaryColor = env == 'PROD'
        ? const Color(0xFF001F3F) // Biru Gelap wajib untuk PROD
        : Colors.teal; // Warna bebas untuk DEV

    return MaterialApp(
      title: 'Enterprise Smart Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        appBarTheme: AppBarTheme(backgroundColor: primaryColor),
      ),
      home: const MainScreen(), // Arahkan langsung ke MainPage home kamu
    );
  }
}
