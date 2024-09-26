import 'package:flutter/material.dart';
import 'package:food_delivery_app/themes/app_colors.dart';

class CustomRichtext extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color? color;
  final double? fontSize;
  const CustomRichtext({
    required this.onPressed,
    required this.text,
    this.fontSize,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
      child: Text(
        text,
        style: TextStyle(color: color ?? AppColors.kPrimary, fontSize: 14),
      ),
    );
  }
}
