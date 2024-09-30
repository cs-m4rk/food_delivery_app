import 'package:flutter/material.dart';
import 'package:food_delivery_app/themes/app_colors.dart';

class MyContainer extends StatelessWidget {
  const MyContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.kWhiteColor,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: const EdgeInsets.all(8.0),
      child: child,
    );
  }
}
