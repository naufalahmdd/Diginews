import 'package:flutter/material.dart';
import '../../../../features/news/presentation/pages/news_page.dart'; 
import '../../../../features/profile/presentation/pages/profile_page.dart'; 

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const NewsPage(),  
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    const String env = String.fromEnvironment('ENV', defaultValue: 'DEV');
    final Color primaryColor = env == 'PROD' 
        ? const Color(0xFF001F3F)
        : Colors.teal; // Bebas untuk DEV[cite: 1]

    return Scaffold(
      appBar: AppBar(
        title: Text(
          env == 'PROD' ? 'UTD - 20123083' : 'DEV - Naufal',
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: primaryColor,
        elevation: 2,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper_rounded),
            label: 'Berita',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}