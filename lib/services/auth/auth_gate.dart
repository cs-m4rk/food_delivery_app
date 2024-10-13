import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/bottom_navbar.dart';
import 'package:food_delivery_app/routes/app_routes.dart';
import 'package:food_delivery_app/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});
  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  bool _isOnboardingComplete = false;

  @override
  void initState() {
    super.initState();
    _checkOnboardingStatus();
  }

  Future<void> _checkOnboardingStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isOnboardingComplete = prefs.getBool('onboardingComplete') ?? false;
      // Loading finished
    });

    if (!_isOnboardingComplete) {
      Navigator.pushNamed(context, AppRoutes.onboarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user is logged in

          if (snapshot.hasData) {
            return const BottomNavbar();
          }
          // user is not logged in
          else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
