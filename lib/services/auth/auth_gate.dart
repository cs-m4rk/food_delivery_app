import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/bottom_navbar.dart';
import 'package:food_delivery_app/routes/app_routes.dart';
import 'package:food_delivery_app/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingCheck extends StatefulWidget {
  const OnboardingCheck({super.key});

  @override
  State<OnboardingCheck> createState() => _OnboardingCheckState();
}

class _OnboardingCheckState extends State<OnboardingCheck> {
  bool _isOnboardingComplete = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkOnboardingStatus();
  }

  Future<void> _checkOnboardingStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isOnboardingComplete = prefs.getBool('onboardingComplete') ?? false;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // If onboarding is complete, proceed to the AuthGate
    if (_isOnboardingComplete) {
      return const AuthGate();
    } else {
      // If onboarding is not complete, navigate to the onboarding screen
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, AppRoutes.onboarding);
      });
      return const SizedBox(); // Return an empty widget while navigating
    }
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // User is logged in
          if (snapshot.hasData) {
            return const BottomNavbar();
          }
          // User is not logged in
          else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
