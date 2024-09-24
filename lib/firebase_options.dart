// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCKA4fKS9WmHdgWkyhNxwHyThHNwGIk0lU',
    appId: '1:434113803542:web:682bf48fb4614270cc8c37',
    messagingSenderId: '434113803542',
    projectId: 'food-delivery-app-fc8a5',
    authDomain: 'food-delivery-app-fc8a5.firebaseapp.com',
    storageBucket: 'food-delivery-app-fc8a5.appspot.com',
    measurementId: 'G-R7JBZD7K8D',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDzdFkbfYhL1namKzu3GwqA0ZmRv2VV7kk',
    appId: '1:434113803542:android:17c40c55ab1722f4cc8c37',
    messagingSenderId: '434113803542',
    projectId: 'food-delivery-app-fc8a5',
    storageBucket: 'food-delivery-app-fc8a5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAIhMOO9-X8NiTmqN2_hYCXfKPzEnh24A4',
    appId: '1:434113803542:ios:da49636a600ed599cc8c37',
    messagingSenderId: '434113803542',
    projectId: 'food-delivery-app-fc8a5',
    storageBucket: 'food-delivery-app-fc8a5.appspot.com',
    iosBundleId: 'com.example.foodDeliveryApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAIhMOO9-X8NiTmqN2_hYCXfKPzEnh24A4',
    appId: '1:434113803542:ios:da49636a600ed599cc8c37',
    messagingSenderId: '434113803542',
    projectId: 'food-delivery-app-fc8a5',
    storageBucket: 'food-delivery-app-fc8a5.appspot.com',
    iosBundleId: 'com.example.foodDeliveryApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCKA4fKS9WmHdgWkyhNxwHyThHNwGIk0lU',
    appId: '1:434113803542:web:ff891dccc6e7e60fcc8c37',
    messagingSenderId: '434113803542',
    projectId: 'food-delivery-app-fc8a5',
    authDomain: 'food-delivery-app-fc8a5.firebaseapp.com',
    storageBucket: 'food-delivery-app-fc8a5.appspot.com',
    measurementId: 'G-1W1520LGEP',
  );
}
