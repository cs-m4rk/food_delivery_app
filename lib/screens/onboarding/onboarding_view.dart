import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/components/export_components/login_components.dart';
import 'package:food_delivery_app/routes/app_routes.dart';
import '/models/onboarding.dart';
import 'package:food_delivery_app/screens/login_screen.dart';
import '/screens/onboarding/components/custom_indicator.dart';
import '/screens/onboarding/components/onboarding_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/screens/home_screen.dart'; // Adjusted to BottomNavbar

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  Future<void> completeOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('onboardingComplete', true);
  }

  

  PageController pageController = PageController();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark));

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 50.h),
            Expanded(
              flex: 3,
              child: PageView.builder(
                itemCount: onboardingList.length,
                controller: pageController,
                onPageChanged: (value) {
                  setState(() {
                    currentIndex = value;
                  });
                },
                itemBuilder: (context, index) {
                  return OnBoardingCard(
                    index: index,
                    onBoarding: onboardingList[index],
                  );
                },
              ),
            ),
            CustomIndicator(position: currentIndex),
            SizedBox(height: 83.h),
            PrimaryButton(
              width: 130.w,
              onTap: () {
                if (currentIndex == (onboardingList.length - 1)) {
                  completeOnboarding();
                  Navigator.pushNamed(context, AppRoutes.login);
                  // After completing onboarding, check auth
                } else {
                  pageController.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease);
                }
              },
              text: currentIndex == (onboardingList.length - 1)
                  ? 'Get Started'
                  : 'Next',
            ),
          ],
        ),
      ),
    );
  }
}
