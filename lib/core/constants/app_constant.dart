import 'package:flutter/material.dart';


enum AppFlavor { dev, prod }

class AppConstants {
  AppConstants._();

  static const String firstName = 'Naufal';
  static const String nim = '20123083';

  static int get lastNimDigit => int.parse(nim[nim.length - 1]);

  static bool get isLastDigitOdd => lastNimDigit % 2 != 0;

  static String appName(AppFlavor flavor) {
    switch (flavor) {
      case AppFlavor.dev:
        return 'DEV - $firstName';
      case AppFlavor.prod:
        return 'UTD - $nim';
    }
  }

  static Color primaryColor(AppFlavor flavor) {
    switch (flavor) {
      case AppFlavor.dev:
        return const Color(0xFFFF6B35);
      case AppFlavor.prod:
        return const Color(0xFF0D1B4C);
    }
  }

  // ==== NEWS API ====
  // Daftar gratis di https://newsapi.org lalu ganti API key di bawah,
  // atau pakai --dart-define=NEWS_API_KEY=xxxx saat build/run.
  static const String newsApiKey = String.fromEnvironment(
    'NEWS_API_KEY',
    defaultValue: 'YOUR_NEWSAPI_KEY_HERE',
  );
  static const String newsBaseUrl = 'https://newsapi.org/v2';
}