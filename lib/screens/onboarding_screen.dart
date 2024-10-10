import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/components/export_components/login_components.dart';
import 'package:food_delivery_app/components/onboarding_card.dart';
import '/models/onboarding.dart';
import 'package:food_delivery_app/screens/login_screen.dart';


import 'package:get/get.dart';

import '../components/custom_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController pageController = PageController();
  int currentIndex = 0;

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
                  Get.offAll(() => const LoginScreen());
                } else {
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                }
              },
              title: currentIndex == (onboardingList.length - 1)
                  ? 'Get Started'
                  : 'Next',
            ),
          ],
        ),
      ),
    );
  }
}
