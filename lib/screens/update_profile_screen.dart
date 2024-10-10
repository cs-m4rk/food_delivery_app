import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/export_components/login_components.dart';
import 'package:food_delivery_app/components/primary_textformfield.dart';
import 'package:food_delivery_app/models/user.dart';
import 'package:food_delivery_app/services/auth/auth_service.dart';
import 'package:food_delivery_app/services/database/database.dart';
import 'package:food_delivery_app/themes/app_colors.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  Uint8List? selectedImage;
  String? imageUrl;

  pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    }
  }

  void selectImage() async {
    Uint8List? imageBytes = await pickImage(ImageSource.gallery);
    if (imageBytes != null) {
      setState(() {
        selectedImage = imageBytes;
      });
    }
  }

  Database db = Database();
  final userId = AuthService().getCurrentUser()!.uid;

  Future<void> updateUserDetails() async {
    try {
      if (selectedImage != null) {
        imageUrl = await db.uploadProfileImageToStorage(selectedImage!, userId);
      }

      final updateUserDetails = User(
        email: emailController.text,
        fullName: fullNameController.text,
        phoneNumber: phoneNumberController.text,
        imageUrl: imageUrl,
      );

      await db.updateUserDetails(updateUserDetails, userId);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully.')),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating profile: $e')),
      );
    }
  }

  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: FutureBuilder<User?>(
        future: db.getUserDetails(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No user data found.'));
          }

          final user = snapshot.data!;

          fullNameController.text = user.fullName;
          emailController.text = user.email;
          phoneNumberController.text = user.phoneNumber ?? '';
          imageUrl = user.imageUrl;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Stack(
                  children: [
                    imageUrl != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: SizedBox(
                              width: 120,
                              height: 120,
                              child: Image.network(
                                imageUrl!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: SizedBox(
                              width: 120,
                              height: 120,
                              child: Image.asset(
                                'assets/profile.png', // Default placeholder
                                fit: BoxFit.cover,
                              ),
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
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                          color: AppColors.kSecondary,
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.edit,
                          ),
                          color: Colors.white,
                          iconSize: 20,
                          onPressed: () => selectImage(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Form(
                  child: Column(
                    children: [
                      PrimaryTextformfield(
                        controller: fullNameController,
                        labelText: 'Full Name',
                        prefixIcon: Icon(Icons.person),
                        useBottomBorder: true,
                      ),
                      PrimaryTextformfield(
                        controller: emailController,
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                        useBottomBorder: true,
                      ),
                      PrimaryTextformfield(
                        controller: phoneNumberController,
                        labelText: 'Phone Number',
                        prefixIcon: Icon(Icons.phone),
                        useBottomBorder: true,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      PrimaryButton(
                        onTap: () => updateUserDetails(),
                        title: 'Update Profile',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
