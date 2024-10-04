import 'package:flutter/material.dart';
import 'package:food_delivery_app/themes/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onTap;
  final String? text;
  final double? width;
  final double? height;
  final double? borderRadius;
  final double? fontSize;
  final Color? color;
  final Widget? icon;
  final SizedBox? spacer;
  final Widget? child;

  const PrimaryButton({
    required this.onTap,
    this.text,
    this.height,
    this.width,
    this.borderRadius,
    this.fontSize,
    this.color,
    this.icon,
    Key? key,
    this.child,
    this.spacer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        child: Container(
          height: height ?? 55,
          alignment: Alignment.center,
          width: width ?? double.maxFinite,
          decoration: BoxDecoration(
            color: color ?? AppColors.kPrimary,
            borderRadius: BorderRadius.circular(borderRadius ?? 30),
          ),
          child: child ??
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    icon!,
                    const SizedBox(width: 5),
                  ],
                  spacer ?? const SizedBox(),
                  Text(
                    text ?? '',
                    style: TextStyle(
                      color: color == null ? Colors.white : Colors.black,
                      fontSize: fontSize ?? 15,
                    ),
                  ),
                ],
              ),
        ),
      ),
    );
  }
}
