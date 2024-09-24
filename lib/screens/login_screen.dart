import 'package:flutter/material.dart';
import 'package:food_delivery_app/app_image_path.dart';
import 'package:food_delivery_app/themes/app_color.dart';
import 'package:food_delivery_app/components/export_components/login_components.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BackgroundImageContainer(
        child: Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 235, right: 263, bottom: 15, left: 32),
            child: Text(
              'Log in',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter',
                color: AppColor.kLightAccentColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              width: 358,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColor.kSamiDarkColor.withOpacity(0.4),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.kSamiDarkColor.withOpacity(0.5),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Container(
                color: Colors.transparent,
                child: Column(
                  children: [
                    PrimaryTextFormField(
                      hintText: 'Email',
                      controller: emailController,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      width: 326,
                      height: 48,
                      fillColor: AppColor.kLightAccentColor,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    PrimaryButton(
                      onTap: () {},
                      borderRadius: 8,
                      fontSize: 14,
                      height: 48,
                      width: 326,
                      text: 'Continue',
                      textColor: AppColor.kWhiteColor,
                      bgColor: AppColor.kPrimary,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    PrimaryTextButton(
                      title: 'Forgot password?',
                      fontSize: 14,
                      onPressed: () {},
                      textColor: AppColor.kPrimary,
                    ),
                    const SizedBox(height: 32),
                    const DividerRow(),
                    const SizedBox(height: 32),
                    SecondaryButton(
                        onTap: () {},
                        borderRadius: 8,
                        fontSize: 14,
                        height: 48,
                        width: 326,
                        text: 'Login with Facebook',
                        textColor: AppColor.kBlackColor,
                        bgColor: AppColor.kLightAccentColor,
                        icons: AppImagePath.kLogoFacebook),
                    const SizedBox(height: 16),
                    SecondaryButton(
                        onTap: () {},
                        borderRadius: 8,
                        fontSize: 14,
                        height: 48,
                        width: 326,
                        text: 'Login with Google',
                        textColor: AppColor.kBlackColor,
                        bgColor: AppColor.kLightAccentColor,
                        icons: AppImagePath.kGoogleLogo),
                    const SizedBox(
                      height: 16,
                    ),
                    SecondaryButton(
                        onTap: () {},
                        borderRadius: 8,
                        fontSize: 14,
                        height: 48,
                        width: 326,
                        text: 'Login with Apple',
                        textColor: AppColor.kBlackColor,
                        bgColor: AppColor.kLightAccentColor,
                        icons: AppImagePath.kApple),
                    const SizedBox(height: 32),
                    CustomRichText(
                      subtitle: ' Sign up ',
                      title: 'Don’t have an account?',
                      subtitleTextStyle: TextStyle(
                        color: AppColor.kPrimary,
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                      ),
                      onTab: () {},
                    )
                  ],
                ),
              ),
            ),
          )
        ]),
      ),
    ));
  }
}
