import 'package:flutter/material.dart';
import 'package:food_delivery_app/themes/app_colors.dart';

class MyContainer extends StatelessWidget {
  MyContainer({super.key, required this.child, this.width = double.infinity});

  final Widget child;
  double width;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: AppColors.kWhiteColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 2),
              blurRadius: 4,
            ),
          ],
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 8),
        child: child,
      ),
    );
  }
}
