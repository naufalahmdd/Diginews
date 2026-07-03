import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';  
import '../../features/news/presentation/pages/news_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';

// Key global untuk root navigator
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorNewsKey = GlobalKey<NavigatorState>(debugLabel: 'newsShell');
final _shellNavigatorProfileKey = GlobalKey<NavigatorState>(debugLabel: 'profileShell');

class AppRouter {
  static final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/news',
    debugLogDiagnostics: true,
    routes: [
      // StatefulShellRoute mengatur tab agar state halaman tidak ter-reset saat berpindah tab
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainWrapper(navigationShell: navigationShell);
        },
        branches: [
          // Branch Pertama: News
          StatefulShellBranch(
            navigatorKey: _shellNavigatorNewsKey,
            routes: [
              GoRoute(
                path: '/news',
                builder: (context, state) => const NewsPage(),
              ),
            ],
          ),
          // Branch Kedua: Profile
          StatefulShellBranch(
            navigatorKey: _shellNavigatorProfileKey,
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfilePage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

// UPDATE file MainWrapper yang sebelumnya di langkah ini
class MainWrapper extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainWrapper({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    // Ambil nilai FLAVOR untuk warna AppBar agar sesuai tugas awal
    const String flavor = String.fromEnvironment('FLAVOR', defaultValue: 'DEV');
    final bool isProd = flavor == 'PROD';
    final String appBarTitle = isProd ? 'UTD - 20123083' : 'DEV - Naufal';

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) {
          // Navigasi menggunakan shell go_router secara aman
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}