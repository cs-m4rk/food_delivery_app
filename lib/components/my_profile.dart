import 'package:flutter/material.dart';
import 'package:food_delivery_app/themes/app_colors.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({
    super.key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  });

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: AppColors.kPrimary.withOpacity(0.7),
        ),
        child: Icon(icon, color: Colors.white),
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 15, color: textColor),
      ),
      trailing: endIcon
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey.withOpacity(0.3),
              ),
              child: const Icon(Icons.arrow_forward_ios_outlined,
                  color: Colors.grey, size: 22),
            )
          : null,
    );
  }
}
