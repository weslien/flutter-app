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
    apiKey: 'AIzaSyBcdCPjQA8X2dLBNLXwR9sBM8VzdaBWdwE',
    appId: '1:767155170973:web:9afe4e62554faee306ee74',
    messagingSenderId: '767155170973',
    projectId: 'e-glazing-351111',
    authDomain: 'e-glazing-351111.firebaseapp.com',
    storageBucket: 'e-glazing-351111.appspot.com',
    measurementId: 'G-XYN6FPX1D3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB7GRUfB65qZgREZHSTFBjyaTpe13AwEvo',
    appId: '1:767155170973:android:d5397ee2a82c58ed06ee74',
    messagingSenderId: '767155170973',
    projectId: 'e-glazing-351111',
    storageBucket: 'e-glazing-351111.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCibiqddr87gmnO80TuuPvt_7JZCljXmiI',
    appId: '1:767155170973:ios:9cf48d7a0d30dcce06ee74',
    messagingSenderId: '767155170973',
    projectId: 'e-glazing-351111',
    storageBucket: 'e-glazing-351111.appspot.com',
    iosClientId: '767155170973-ngdnd586q80euqvocsejjqq3di0do12g.apps.googleusercontent.com',
    iosBundleId: 'com.example.companyApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCibiqddr87gmnO80TuuPvt_7JZCljXmiI',
    appId: '1:767155170973:ios:9cf48d7a0d30dcce06ee74',
    messagingSenderId: '767155170973',
    projectId: 'e-glazing-351111',
    storageBucket: 'e-glazing-351111.appspot.com',
    iosClientId: '767155170973-ngdnd586q80euqvocsejjqq3di0do12g.apps.googleusercontent.com',
    iosBundleId: 'com.example.companyApp',
  );
}
