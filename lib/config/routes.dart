import 'package:flutter/material.dart';
import '../presentation/screens/splash/splash_screen.dart';
import '../presentation/screens/home/home_screen.dart';

class AppRoutes {
  // Route Names
  static const String splash = '/';
  static const String home = '/home';
  static const String stockDetail = '/stock-detail';
  static const String orderPlace = '/order-place';
  static const String portfolio = '/portfolio';
  static const String profile = '/profile';
  static const String settings = '/settings';
  
  // Generate Route
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
