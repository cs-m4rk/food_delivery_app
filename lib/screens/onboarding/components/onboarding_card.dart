import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/themes/app_colors.dart';
import '/models/onboarding.dart';
import 'package:get/get.dart';

class OnBoardingCard extends StatelessWidget {
  final Onboarding onBoarding;
  final int index;
  const OnBoardingCard({
    required this.onBoarding,
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      duration: const Duration(milliseconds: 1400),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(onBoarding.image), fit: BoxFit.fill)),
        child: Column(
          children: [
            const Spacer(),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                TextSpan(
                  text: onBoarding.title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.kPrimary,
                      fontSize: 25),
                )
              ]),
            ),
            SizedBox(height: 20.h),
            Text(
              onBoarding.description,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}
