import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:automobile/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: const String.fromEnvironment(
        'FIREBASE_API_KEY',
        defaultValue: 'demo-api-key',
      ),
      appId: _firebaseAppId(),
      messagingSenderId: const String.fromEnvironment(
        'FIREBASE_MESSAGING_SENDER_ID',
        defaultValue: '1234567890',
      ),
      projectId: const String.fromEnvironment(
        'FIREBASE_PROJECT_ID',
        defaultValue: 'automobile-demo',
      ),
      storageBucket: const String.fromEnvironment(
        'FIREBASE_STORAGE_BUCKET',
        defaultValue: 'automobile-demo.appspot.com',
      ),
    ),
  );
  runApp(const ProviderScope(child: AutoMobileApp()));
}

String _firebaseAppId() {
  const configuredAppId = String.fromEnvironment('FIREBASE_APP_ID');
  if (configuredAppId.isNotEmpty) {
    return configuredAppId;
  }

  if (kIsWeb) {
    return '1:1234567890:web:1234567890abcdef';
  }

  switch (defaultTargetPlatform) {
    case TargetPlatform.iOS:
      return '1:1234567890:ios:1234567890abcdef';
    case TargetPlatform.android:
      return '1:1234567890:android:1234567890abcdef';
    case TargetPlatform.macOS:
      return '1:1234567890:macos:1234567890abcdef';
    case TargetPlatform.windows:
      return '1:1234567890:windows:1234567890abcdef';
    case TargetPlatform.linux:
      return '1:1234567890:linux:1234567890abcdef';
    case TargetPlatform.fuchsia:
      return '1:1234567890:fuchsia:1234567890abcdef';
  }
}
