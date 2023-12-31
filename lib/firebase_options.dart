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
    apiKey: 'AIzaSyASM4rd9HfS0HWMNAkeD9Cr_TtnOE2bnBs',
    appId: '1:974355530106:web:3978f267518b9a0b0e96c3',
    messagingSenderId: '974355530106',
    projectId: 'todo-agri-hawk',
    authDomain: 'todo-agri-hawk.firebaseapp.com',
    storageBucket: 'todo-agri-hawk.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDIR92FscraE7Qxz9c4LlHflm2Au9aBEp8',
    appId: '1:974355530106:android:2c668ead500ed4190e96c3',
    messagingSenderId: '974355530106',
    projectId: 'todo-agri-hawk',
    storageBucket: 'todo-agri-hawk.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAqK8LrKE_tE7Mcf0aLQ_00GfaBILtqkk8',
    appId: '1:974355530106:ios:f8c72112896229f20e96c3',
    messagingSenderId: '974355530106',
    projectId: 'todo-agri-hawk',
    storageBucket: 'todo-agri-hawk.appspot.com',
    iosClientId: '974355530106-g2htkdc8jsbu7mj5ehpa2dn6iaidjhsv.apps.googleusercontent.com',
    iosBundleId: 'com.example.newTodo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAqK8LrKE_tE7Mcf0aLQ_00GfaBILtqkk8',
    appId: '1:974355530106:ios:f4f5a13776cef4a40e96c3',
    messagingSenderId: '974355530106',
    projectId: 'todo-agri-hawk',
    storageBucket: 'todo-agri-hawk.appspot.com',
    iosClientId: '974355530106-8e9e9dfm6i62rtt5ctv4vlcrbc5hltqt.apps.googleusercontent.com',
    iosBundleId: 'com.example.newTodo.RunnerTests',
  );
}
