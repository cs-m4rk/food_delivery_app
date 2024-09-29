import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/bottom_navbar.dart';
import 'package:food_delivery_app/screens/address_screen.dart';
import 'package:food_delivery_app/screens/cart_screen.dart';
import 'package:food_delivery_app/screens/login_screen.dart';
import 'package:food_delivery_app/screens/register_screen.dart';

class AppRoutes {
  static const String login = '/';
  static const String register = '/register';
  static const String home = '/home';
  static const String food = '/food';
  static const String cart = '/cart';
  static const String address = '/address';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => BottomNavbar());
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case cart:
        return MaterialPageRoute(builder: (_) => CartScreen());
      case address:
        return MaterialPageRoute(builder: (_) => AddressScreen());
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
