// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;

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
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyACWcARFaLYXMZm8xY55908QGuE0vYYX50',
    appId: '1:879495212525:android:4f868f5a4d5827f2830be4',
    messagingSenderId: '879495212525',
    projectId: 'glucoseguardian',
    storageBucket: 'glucoseguardian.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCg5T9e3Noxx8twT86JahQ0e-2mTsc1wqU',
    appId: '1:879495212525:ios:32841e01934f41db830be4',
    messagingSenderId: '879495212525',
    projectId: 'glucoseguardian',
    storageBucket: 'glucoseguardian.appspot.com',
    iosClientId:
        '879495212525-lb4q0b9n001mn08uvbr8n3084ug9b8af.apps.googleusercontent.com',
    iosBundleId: 'com.example.glucoseGuardian',
  );
}
