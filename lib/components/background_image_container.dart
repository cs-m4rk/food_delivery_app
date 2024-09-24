import 'package:flutter/material.dart';
import 'package:food_delivery_app/app_image_path.dart';

class BackgroundImageContainer extends StatelessWidget {
  const BackgroundImageContainer({
    super.key,
    required this.child,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                AppImagePath.kRectangleBackgound,
              ),
              fit: BoxFit.cover)),
      child: child,
    );
  }
}
