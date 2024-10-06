import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_delivery_app/models/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  //login
  Future<UserCredential> login(String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // currentUser
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  //register
  Future<UserCredential> register(
      String email, String password, String fullName) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCredential.user!.updateProfile(displayName: fullName);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null; // User canceled the sign-in
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      print("Error during Google Sign-In: $e");
      return null;
    }
  }

    Stream<UserModel?> get userStream {
    return _firebaseAuth.authStateChanges().map((User? user) {
      if (user != null) {
        // If logged in, convert to UserModel
        return UserModel.fromFirebaseUser(user);
      } else {
        return null; // Not logged in
      }
    });
  }
  //logout
  Future<void> logout() async {
    await _firebaseAuth.signOut();
    
  }
}
