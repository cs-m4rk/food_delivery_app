import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/bottom_navbar.dart';
import 'package:food_delivery_app/screens/address_screen.dart';
import 'package:food_delivery_app/screens/cart_screen.dart';
import 'package:food_delivery_app/screens/login_screen.dart';
import 'package:food_delivery_app/screens/onboarding_screen.dart';
import 'package:food_delivery_app/screens/new_address_screen.dart';
import 'package:food_delivery_app/screens/payment_screen.dart';
import 'package:food_delivery_app/screens/purchased_screen.dart';
import 'package:food_delivery_app/screens/register_screen.dart';
import 'package:food_delivery_app/screens/update_profile_screen.dart';

class AppRoutes {
  static const String login = '/';
  static const String register = '/register';
  static const String home = '/home';
  static const String food = '/food';

  static const String updateProfile = '/updateProfile';
  static const String profile = '/profile';
  static const String onboarding = '/onboarding';
  static const String payment = '/payment';

  static const String cart = '/cart';
  static const String address = '/address';
  static const String purchased = '/purchased';
  static const String addressScreen = '/address';

  static const String newAddress = '/newaddress';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => BottomNavbar());
      case payment:
        return MaterialPageRoute(
            builder: (_) => const PaymentScreen(
                  selectedItems: [],
                ));
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case address:
        return MaterialPageRoute(builder: (_) => AddressScreen());
      case register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());

      case updateProfile:
        return MaterialPageRoute(builder: (_) => UpdateProfileScreen());
      case onboarding:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());
      case purchased:
        return MaterialPageRoute(builder: (_) => PurchasedScreen());
      case cart:
        return MaterialPageRoute(builder: (_) => CartScreen());

      case newAddress:
        return MaterialPageRoute(builder: (_) => NewAddressScreen());
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
