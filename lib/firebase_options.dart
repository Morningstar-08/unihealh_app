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
        return macos;
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
    apiKey: 'AIzaSyBOprYQ3QtIkkyb6DB0kdYmdJEYO01kkbc',
    appId: '1:1067342925663:web:4fe8a510a9607f30e570ea',
    messagingSenderId: '1067342925663',
    projectId: 'unihealth-5cc4a',
    authDomain: 'unihealth-5cc4a.firebaseapp.com',
    storageBucket: 'unihealth-5cc4a.appspot.com',
    measurementId: 'G-S4K7JDYKMC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCakyrICUuk5wvABSmItdfuk4GhK8eegRs',
    appId: '1:1067342925663:android:7a90922280c2b9cfe570ea',
    messagingSenderId: '1067342925663',
    projectId: 'unihealth-5cc4a',
    storageBucket: 'unihealth-5cc4a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCrVHLaJjlXWiFc92dtXQZOw4OpSRU-CcQ',
    appId: '1:1067342925663:ios:983b652dd412c3e1e570ea',
    messagingSenderId: '1067342925663',
    projectId: 'unihealth-5cc4a',
    storageBucket: 'unihealth-5cc4a.appspot.com',
    iosBundleId: 'com.example.healthCareApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCrVHLaJjlXWiFc92dtXQZOw4OpSRU-CcQ',
    appId: '1:1067342925663:ios:f12aafbcf91cf365e570ea',
    messagingSenderId: '1067342925663',
    projectId: 'unihealth-5cc4a',
    storageBucket: 'unihealth-5cc4a.appspot.com',
    iosBundleId: 'com.example.healthCareApp.RunnerTests',
  );
}
