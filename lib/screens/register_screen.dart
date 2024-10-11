import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/animations/fade_animation.dart';
import 'package:food_delivery_app/app_image_path.dart';
import 'package:food_delivery_app/components/export_components/register_components.dart';
import 'package:food_delivery_app/components/primary_textformfield.dart';
import 'package:food_delivery_app/models/user.dart' as app_user;
import 'package:food_delivery_app/routes/app_routes.dart';
import 'package:food_delivery_app/services/auth/auth_service.dart';
import 'package:food_delivery_app/services/database/database.dart';
import 'package:food_delivery_app/themes/app_colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackground,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: FadeAnimation(
            delay: 1,
            child: Column(
              children: [
                Center(child: Image.asset(AppImagePath.kAppLogo)),
                const SizedBox(height: 30),
                PrimaryTextformfield(
                  controller: _usernameController,
                  labelText: 'Full name',
                  keyboardType: TextInputType.name,
                  validator: validateName,
                ),
                const SizedBox(height: 20),
                PrimaryTextformfield(
                  controller: _emailController,
                  labelText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  validator: validateEmail,
                ),
                const SizedBox(height: 20),
                PrimaryTextformfield(
                  labelText: 'Password',
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  isPasswordField: true,
                  validator: passwordValidator,
                ),
                const SizedBox(height: 20),
                PrimaryTextformfield(
                  labelText: 'Confirm Password',
                  controller: _confirmPasswordController,
                ),
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  ),
                const SizedBox(height: 30),
                PrimaryButton(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        await register();
                      }
                    },
                    title: 'Sign Up'),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?',
                        style: TextStyle(
                          fontSize: 14,
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    PrimaryTextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.login);
                      },
                      title: 'Log in',
                      fontSize: 14,
                      textColor: AppColors.kPrimary,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }

    return null;
  }

  String? validateEmail(String? value) {
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }

    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 6) {
      return 'Password should be at least 6 characters';
    }

    return null;
  }

  Future<void> register() async {
    final authService = AuthService();
    final database = Database();

    if (_passwordController.text == _confirmPasswordController.text) {
      try {
        // trying to register
        UserCredential userCredential = await authService.register(
          _emailController.text,
          _passwordController.text,
          _usernameController.text,
        );

        app_user.User userDetails = app_user.User(
          fullName: _usernameController.text,
          email: _emailController.text,
        );

        // save user details to Firestore
        await database.saveUserDetails(userDetails, userCredential.user!.uid);

        Navigator.pushReplacementNamed(context, AppRoutes.home);
      } catch (e) {
        setState(() {
          _errorMessage = 'Registration or login failed. Please try again.';
        });
      }
    } else {
      setState(() {
        _errorMessage = 'Password does not match';
      });
    }
  }
}
