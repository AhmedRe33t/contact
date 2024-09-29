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
    apiKey: 'AIzaSyD_Y7MhrUQYrOvZY1Aa0YwbJlsroCK9dcY',
    appId: '1:667859003944:web:aac7acc65a10bdea7a631d',
    messagingSenderId: '667859003944',
    projectId: 'newcontact-3e2c8',
    authDomain: 'newcontact-3e2c8.firebaseapp.com',
    storageBucket: 'newcontact-3e2c8.appspot.com',
    measurementId: 'G-XCVHSC4F3E',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDP_IW32NauOCvjfOFmAeokxn6kO5pgzJs',
    appId: '1:667859003944:android:75190e4da6b1b4107a631d',
    messagingSenderId: '667859003944',
    projectId: 'newcontact-3e2c8',
    storageBucket: 'newcontact-3e2c8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDfMkgyEKDfMXq5xRLJXNgMgsy2l6178H8',
    appId: '1:667859003944:ios:06213e0eb79f59c77a631d',
    messagingSenderId: '667859003944',
    projectId: 'newcontact-3e2c8',
    storageBucket: 'newcontact-3e2c8.appspot.com',
    iosBundleId: 'com.example.firebaseproject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDfMkgyEKDfMXq5xRLJXNgMgsy2l6178H8',
    appId: '1:667859003944:ios:06213e0eb79f59c77a631d',
    messagingSenderId: '667859003944',
    projectId: 'newcontact-3e2c8',
    storageBucket: 'newcontact-3e2c8.appspot.com',
    iosBundleId: 'com.example.firebaseproject',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD_Y7MhrUQYrOvZY1Aa0YwbJlsroCK9dcY',
    appId: '1:667859003944:web:be507107eac155ad7a631d',
    messagingSenderId: '667859003944',
    projectId: 'newcontact-3e2c8',
    authDomain: 'newcontact-3e2c8.firebaseapp.com',
    storageBucket: 'newcontact-3e2c8.appspot.com',
    measurementId: 'G-MQY0PMM0NW',
  );
}
