import 'package:flutter/material.dart';
import 'package:food_delivery_app/animations/fade_animation.dart';
import 'package:food_delivery_app/app_image_path.dart';
import 'package:food_delivery_app/components/primary_textformfield.dart';
import 'package:food_delivery_app/routes/app_routes.dart';
import 'package:food_delivery_app/services/auth/auth_service.dart';
import 'package:food_delivery_app/themes/app_colors.dart';
import 'package:food_delivery_app/components/export_components/login_components.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _errorMessage;
  bool _isObscure = true;
  bool _isPasswordFieldEmpty = true;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      setState(() {
        _isPasswordFieldEmpty = _passwordController.text.isEmpty;
      });
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackground,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          child: Form(
            key: _formKey,
            child: FadeAnimation(
              delay: 1,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: SizedBox(
                      width: 90,
                      height: 90,
                      child: Image.asset(
                        AppImagePath.kAppLogo,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Welcome to ',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: 'Moodeng Bite',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.kPrimary,
                          ),
                        ),
                        TextSpan(
                          text: ', where every bite is a delight!',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  PrimaryTextformfield(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    labelText: 'Email',
                    prefixIcon: const Icon(
                      Icons.email,
                      color: AppColors.kPrimary,
                    ),
                    validator: validateEmail,
                  ),
                  const SizedBox(height: 20),
                  PrimaryTextformfield(
                    labelText: 'Password',
                    controller: _passwordController,
                    obscureText: _isObscure,
                    suffixIcon: _isPasswordFieldEmpty
                        ? null
                        : IconButton(
                            icon: Icon(_isObscure
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                          ),
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: AppColors.kPrimary,
                    ),
                    validator: validatePassword,
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
                  const SizedBox(height: 25),
                  const DividerRow(),
                  const SizedBox(height: 25),
                  SecondaryButton(
                    onTap: () {},
                    text: 'Sign in with Google',
                    borderRadius: 20,
                    height: 60,
                    width: double.infinity,
                    bgColor: AppColors.kWhiteColor,
                    icons: AppImagePath.kGoogleLogo,
                    iconHeight: 36,
                    iconWidth: 36,
                    fontSize: 16,
                  ),
                  const SizedBox(
                    height: 16,
                    width: 20,
                  ),
                  const SizedBox(height: 25),
                  PrimaryButton(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          await login();
                        }
                      },
                      title: 'Sign In'),
                  const SizedBox(height: 25),
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
      ),
    );
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

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 6) {
      return 'Password should be at least 6 characters';
    }
    return null;
  }

  Future<void> login() async {
    final authService = AuthService();

    try {
      await authService.login(_emailController.text, _passwordController.text);
      setState(() {
        _errorMessage = null;
      });
    } catch (e) {
      setState(() {
        _errorMessage =
            'Login failed. Please check your credentials and try again';
      });
    }
  }
}
