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
    apiKey: 'AIzaSyCci6mwGXcISJ9siUY3qvg-6B7EO6Whfx8',
    appId: '1:743053782422:web:b35954239756e6c0dd41b7',
    messagingSenderId: '743053782422',
    projectId: 'whatsapp-web-projeto-gomes',
    authDomain: 'whatsapp-web-projeto-gomes.firebaseapp.com',
    storageBucket: 'whatsapp-web-projeto-gomes.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBH19Gk2X4C4kSsifCR4fPJ4OltP_pKa4M',
    appId: '1:743053782422:android:0386c709179d67bddd41b7',
    messagingSenderId: '743053782422',
    projectId: 'whatsapp-web-projeto-gomes',
    storageBucket: 'whatsapp-web-projeto-gomes.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyChi863GEwOiuUGnYIrylF221Bd_P01vQk',
    appId: '1:743053782422:ios:6175b5d80ae3a3eedd41b7',
    messagingSenderId: '743053782422',
    projectId: 'whatsapp-web-projeto-gomes',
    storageBucket: 'whatsapp-web-projeto-gomes.appspot.com',
    iosClientId: '743053782422-594370cl0rvcgec8ctbjm8rub7jnibvd.apps.googleusercontent.com',
    iosBundleId: 'com.example.whatsappweb',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyChi863GEwOiuUGnYIrylF221Bd_P01vQk',
    appId: '1:743053782422:ios:6175b5d80ae3a3eedd41b7',
    messagingSenderId: '743053782422',
    projectId: 'whatsapp-web-projeto-gomes',
    storageBucket: 'whatsapp-web-projeto-gomes.appspot.com',
    iosClientId: '743053782422-594370cl0rvcgec8ctbjm8rub7jnibvd.apps.googleusercontent.com',
    iosBundleId: 'com.example.whatsappweb',
  );
}