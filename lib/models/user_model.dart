import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String? displayName;
  final String? email;
  final String? photoURL;

  UserModel({
    required this.displayName,
    required this.email,
    required this.photoURL,
  });

  // Method to create a UserModel from Firebase User
  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      displayName: user.displayName,
      email: user.email,
      photoURL: user.photoURL,
    );
  }
}
