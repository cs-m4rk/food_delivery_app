import 'package:flutter/material.dart';
import 'package:food_delivery_app/app_image_path.dart';
import 'package:food_delivery_app/routes/app_routes.dart';
import 'package:food_delivery_app/themes/app_color.dart';
import 'package:food_delivery_app/components/export_components/login_components.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BackgroundImageContainer(
      child: Scaffold(
        backgroundColor: AppColor.kBackGroundColor,
        body: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 530,
                  width: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColor.kWhiteColor,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade400,
                          offset: const Offset(3.0, 4.0),
                          blurRadius: 9,
                          spreadRadius: 1.0)
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Column(
                      children: [
                        PrimaryTextFormField(
                          hintText: 'Email',
                          controller: emailController,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          width: 326,
                          height: 48,
                          fillColor: AppColor.kLightAccentColor,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        PrimaryTextFormField(
                          hintText: 'Password',
                          controller: passwordController,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
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
                          text: 'Login',
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SecondaryButton(
                                onTap: () {},
                                borderRadius: 8,
                                height: 65,
                                width: 65,
                                bgColor: AppColor.kWhiteColor,
                                icons: AppImagePath.kLogoFacebook,
                                iconHeight: 38,
                                iconWidth: 38,
                              ),
                              const SizedBox(height: 16),
                              SecondaryButton(
                                onTap: () {},
                                borderRadius: 8,
                                height: 65,
                                width: 65,
                                bgColor: AppColor.kLightAccentColor,
                                icons: AppImagePath.kGoogleLogo,
                                iconHeight: 38,
                                iconWidth: 38,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              SecondaryButton(
                                onTap: () {},
                                borderRadius: 8,
                                height: 65,
                                width: 65,
                                bgColor: AppColor.kLightAccentColor,
                                icons: AppImagePath.kApple,
                                iconHeight: 38,
                                iconWidth: 38,
                              ),
                            ],
                          ),
                        ),
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
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.register);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
