import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/animations/fade_animation.dart';
import 'package:food_delivery_app/app_image_path.dart';
import 'package:food_delivery_app/components/bottom_navbar.dart';
import 'package:food_delivery_app/components/primary_textformfield.dart';
import 'package:food_delivery_app/routes/app_routes.dart';
import 'package:food_delivery_app/services/auth/auth_service.dart';
import 'package:food_delivery_app/themes/app_colors.dart';
import 'package:food_delivery_app/components/export_components/login_components.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isEmailCorrect = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackground,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
        child: Form(
          key: _formKey,
          child: FadeAnimation(
            delay: 1,
            child: Column(
              children: [
                Center(
                  child: Image.asset(AppImagePath.kAppLogo),
                ),
                const SizedBox(height: 30),
                PrimaryTextformfield(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  isFieldValidated: isEmailCorrect,
                  onChanged: (value) {
                    setState(() {});
                    isEmailCorrect = validateEmail(value);
                  },
                  labelText: 'Email',
                  // validator: (value) {
                  //   if (!validateEmail(value!)) {
                  //     return 'Please enter a valid email address';
                  //   }
                  //   return null;
                  // },
                ),
                const SizedBox(height: 20),
                PrimaryTextformfield(
                  labelText: 'Password',
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  isForgetButton: true,
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Please enter your password';
                  //   } else if (value.length < 6) {
                  //     return 'Password should be at least 6 characters';+
                  //   } // else if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*d).+$')
                  //   //     .hasMatch(value)) {
                  //   //   return 'Password should contain at least one uppercase letter, one lowercase letter, and one digit';
                  //   // }
                  //   return null;
                  // },
                ),
                const SizedBox(height: 30),
                const DividerRow(),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SecondaryButton(
                      onTap: () {},
                      borderRadius: 8,
                      height: 60,
                      width: 60,
                      bgColor: AppColors.kWhiteColor,
                      icons: AppImagePath.kLogoFacebook,
                      iconHeight: 36,
                      iconWidth: 36,
                    ),
                    const SizedBox(
                      height: 16,
                      width: 20,
                    ),
                    SecondaryButton(
                      onTap: () async {
                        User? user = await AuthService().signInWithGoogle();
                      },
                      borderRadius: 8,
                      height: 60,
                      width: 60,
                      bgColor: AppColors.kWhiteColor,
                      icons: AppImagePath.kGoogleLogo,
                      iconHeight: 36,
                      iconWidth: 36,
                    ),
                    const SizedBox(
                      height: 16,
                      width: 20,
                    ),
                    SecondaryButton(
                      onTap: () {},
                      borderRadius: 8,
                      height: 60,
                      width: 60,
                      bgColor: AppColors.kWhiteColor,
                      icons: AppImagePath.kApple,
                      iconHeight: 36,
                      iconWidth: 36,
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                PrimaryButton(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pushReplacementNamed(context, AppRoutes.home);
                      }
                    },
                    text: 'Sign In'),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?",
                        style: TextStyle(
                          fontSize: 14,
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    PrimaryTextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.register);
                      },
                      title: 'Sign Up',
                      fontSize: 14,
                      textColor: AppColors.kPrimary,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool validateEmail(String value) {
    if (value.isEmpty) {
      return false;
    } else {
      final emailRegex = RegExp(
        r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
      );
      return emailRegex.hasMatch(value);
    }
  }
}
