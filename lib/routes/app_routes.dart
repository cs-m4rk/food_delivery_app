import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/bottom_navbar.dart';
import 'package:food_delivery_app/screens/food_screen.dart';
import 'package:food_delivery_app/screens/login_screen.dart';
import 'package:food_delivery_app/screens/profile_screen.dart';
import 'package:food_delivery_app/screens/register_screen.dart';
import 'package:food_delivery_app/screens/update_profile_screen.dart';

class AppRoutes {
  static const String login = '/';
  static const String register = '/register';
  static const String home = '/home';
  static const String food = '/food';
  static const String updateProfile = '/updateProfile';
    static const String profile = '/profile';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => BottomNavbar());
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case food:
        return MaterialPageRoute(builder: (_) => FoodScreen());
      case register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case updateProfile:
        return MaterialPageRoute(builder: (_) => UpdateProfileScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text("No route defined for ${settings.name}"),
            ),
          ),
        );
    }
  }
}
