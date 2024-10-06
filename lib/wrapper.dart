import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/user_model.dart'; // Import UserModel
import 'package:food_delivery_app/screens/home_screen.dart'; // Adjusted to BottomNavbar
import 'package:food_delivery_app/screens/login_screen.dart';
import 'package:food_delivery_app/screens/onboarding/onboarding_view.dart';
import 'package:food_delivery_app/components/bottom_navbar.dart'; // Add the BottomNavbar import
import 'package:food_delivery_app/screens/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
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
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Scaffold(
            body: Center(child: Text("An error occurred")),
          );
        } else if (snapshot.hasData) {
          // Extract user info from FirebaseAuth User
          User? user = snapshot.data;

          // Create UserModel instance using FirebaseAuth user data
          UserModel userModel = UserModel(
            displayName: user?.displayName,
            email: user?.email,
            photoURL: user?.photoURL,
          );

          return HomeScreen();
        } else {
          return _isOnboardingComplete
              ? const LoginScreen()
              : const OnboardingView();
        }
      },
    );
  }
}
