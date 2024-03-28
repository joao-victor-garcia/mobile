// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCDqFBHj8EJjzdlCOkfW6OjPm2voFsmwi0',
    appId: '1:96663279713:web:884345fd0caf875e12b220',
    messagingSenderId: '96663279713',
    projectId: 'cleaningapp-66e1e',
    authDomain: 'cleaningapp-66e1e.firebaseapp.com',
    databaseURL: 'https://cleaningapp-66e1e-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'cleaningapp-66e1e.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBWt-FtzrMIj0bqMZbhDLt1Qr_jL0dspYY',
    appId: '1:96663279713:android:57b0d6e6f7b2809d12b220',
    messagingSenderId: '96663279713',
    projectId: 'cleaningapp-66e1e',
    databaseURL: 'https://cleaningapp-66e1e-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'cleaningapp-66e1e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBXnrbC0rDkj2E5iFHAMFhvEvFmS5GA_js',
    appId: '1:96663279713:ios:66a44afea76f498812b220',
    messagingSenderId: '96663279713',
    projectId: 'cleaningapp-66e1e',
    databaseURL: 'https://cleaningapp-66e1e-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'cleaningapp-66e1e.appspot.com',
    iosBundleId: 'com.example.cleaningTracker',
  );
}