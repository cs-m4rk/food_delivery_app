import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/bottom_navbar.dart';
import 'package:food_delivery_app/models/user_model.dart';
import 'package:food_delivery_app/screens/login_screen.dart';
import 'package:food_delivery_app/screens/onboarding/onboarding_view.dart';
import 'package:food_delivery_app/screens/payment_screen.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user is logged in

          if (snapshot.hasData) {
            User? user = snapshot.data;

            // Create UserModel instance using FirebaseAuth user data
            UserModel userModel = UserModel(
              displayName: user?.displayName,
              email: user?.email,
              photoURL: user?.photoURL,
            );
            return const BottomNavbar();
          }
          // user is not logged in
          else {
            return _isOnboardingComplete
                ? const LoginScreen()
                : const OnboardingView();
          }
        },
      ),
    );
  }
}
