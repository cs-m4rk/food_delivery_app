import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/export_components/login_components.dart';
import 'package:food_delivery_app/components/my_profile.dart';
import 'package:food_delivery_app/models/user.dart';
import 'package:food_delivery_app/routes/app_routes.dart';
import 'package:food_delivery_app/services/auth/auth_service.dart';
import 'package:food_delivery_app/services/database/database.dart';
import 'package:food_delivery_app/themes/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var title = TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
    );

    final userId = AuthService().getCurrentUser()!.uid;
    Database db = Database();

    return Scaffold(
      backgroundColor: AppColors.kBackground,
      appBar: AppBar(
        backgroundColor: AppColors.kBackground,
        title: Text(
          'Profile',
          style: title,
        ),
      ),
      body: StreamBuilder<User?>(
        stream: db.getUserDetails(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No user data found.'));
          }

          final user = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Stack(
                  children: [
                    user.imageUrl != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: SizedBox(
                              width: 120,
                              height: 120,
                              child: CachedNetworkImage(
                                imageUrl: user.imageUrl!,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: SizedBox(
                              width: 120,
                              height: 120,
                              child: Image.asset(
                                'assets/profile.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  user.fullName,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                Text(
                  user.email,
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                PrimaryButton(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.updateProfile);
                  },
                  title: 'Edit Profile',
                  height: 42,
                  width: 200,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(),
                const SizedBox(
                  height: 10,
                ),
                MyProfile(
                  title: 'Favorites',
                  icon: Icons.favorite,
                  onPress: () {},
                  endIcon: true,
                ),
                MyProfile(
                  title: 'Address',
                  icon: Icons.location_on,
                  onPress: () =>
                      Navigator.pushNamed(context, AppRoutes.address),
                  endIcon: true,
                ),
                MyProfile(
                  title: 'Logout',
                  icon: Icons.logout,
                  onPress: () => AuthService().logout(),
                  endIcon: false,
                  textColor: Colors.red,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
