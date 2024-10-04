import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/user_model.dart';
import 'package:food_delivery_app/routes/app_routes.dart';
import 'package:food_delivery_app/screens/home_screen.dart';
import 'package:food_delivery_app/screens/update_profile_screen.dart';

import 'package:food_delivery_app/themes/app_colors.dart';
import 'package:food_delivery_app/themes/app_colors.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileScreen extends StatelessWidget {

  final UserModel userModel;

  const ProfileScreen({Key? key, required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(LineAwesomeIcons.angle_left_solid),
          ),
          title: Text('Profile'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipOval(
                        child: userModel.photoURL != null
                        ? Image.network(userModel.photoURL!, fit: BoxFit.cover)
                        : Image.asset('assets/images/default_profile.png',
                            fit: BoxFit.cover),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: AppColors.kPrimary.withOpacity(0.3),
                      ),
                      child: IconButton(
                          icon: const Icon(
                            LineAwesomeIcons.pencil_alt_solid,
                          ),
                          color: Colors.white,
                          iconSize: 20,
                          onPressed: () {}),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
             Text(
              userModel.displayName ?? 'No Name',
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            Text(
              userModel.email ?? 'No Email',
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.updateProfile);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.kPrimary,
                      side: BorderSide.none,
                      shape: const StadiumBorder()),
                  child: const Text(
                    'Edit Profile',
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              ProfileMenuWidget(
                title: 'Orders',
                icon: LineAwesomeIcons.receipt_solid,
                onPress: () {},
                endIcon: true,
              ),
              ProfileMenuWidget(
                title: 'Favorites',
                icon: LineAwesomeIcons.heart_solid,
                onPress: () {},
                endIcon: true,
              ),
              ProfileMenuWidget(
                title: 'Location',
                icon: LineAwesomeIcons.long_arrow_alt_down_solid,
                onPress: () {},
                endIcon: true,
              ),
              ProfileMenuWidget(
                title: 'Logout',
                icon: LineAwesomeIcons.sign_out_alt_solid,
                onPress: () {},
                endIcon: false,
                textColor: Colors.red,
              )
            ],
          ),
        ));
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
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
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: AppColors.kPrimary.withOpacity(0.3),
        ),
        child: Icon(icon, color: Colors.white),
      ),
      title: Text(title, style: TextStyle(fontSize: 13)),
      trailing: endIcon
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey.withOpacity(0.3),
              ),
              child: const Icon(LineAwesomeIcons.angle_right_solid,
                  color: Colors.grey),
            )
          : null,
    );
  }
}
