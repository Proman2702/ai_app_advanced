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
    apiKey: 'AIzaSyAXJUZUE-bKuZtSZhv4R_Qs3eHLC1UKb-g',
    appId: '1:609501405481:web:95756ddf1a6056f6da5738',
    messagingSenderId: '609501405481',
    projectId: 'ai-app-736e6',
    authDomain: 'ai-app-736e6.firebaseapp.com',
    storageBucket: 'ai-app-736e6.appspot.com',
    measurementId: 'G-Z88YWB52E5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCSJ1xEgTowQIpRrKj4F6sgE8kNT5hSXDg',
    appId: '1:609501405481:android:9689ad6e89239fa4da5738',
    messagingSenderId: '609501405481',
    projectId: 'ai-app-736e6',
    storageBucket: 'ai-app-736e6.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCMfJISWQWM-_JMeVEbUZN2TjzzsOBTaRk',
    appId: '1:609501405481:ios:81a04891cce3fbd9da5738',
    messagingSenderId: '609501405481',
    projectId: 'ai-app-736e6',
    storageBucket: 'ai-app-736e6.appspot.com',
    iosBundleId: 'com.example.aiApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCMfJISWQWM-_JMeVEbUZN2TjzzsOBTaRk',
    appId: '1:609501405481:ios:81a04891cce3fbd9da5738',
    messagingSenderId: '609501405481',
    projectId: 'ai-app-736e6',
    storageBucket: 'ai-app-736e6.appspot.com',
    iosBundleId: 'com.example.aiApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAXJUZUE-bKuZtSZhv4R_Qs3eHLC1UKb-g',
    appId: '1:609501405481:web:653a16b6340d6c99da5738',
    messagingSenderId: '609501405481',
    projectId: 'ai-app-736e6',
    authDomain: 'ai-app-736e6.firebaseapp.com',
    storageBucket: 'ai-app-736e6.appspot.com',
    measurementId: 'G-XBV65VK685',
  );
}
