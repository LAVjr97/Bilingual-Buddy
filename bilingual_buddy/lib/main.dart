import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'screens/landing_page.dart';   // landing page
import 'firebase_options.dart';
import 'screens/globals.dart';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load .env only on mobile / desktop (not on web).
  if (!kIsWeb) {
    await dotenv.load();
  }

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Enable local-cache persistence.
  FirebaseFirestore.instance.settings =
  const Settings(persistenceEnabled: true);

  createStudentMap();        // your helper from globals.dart
  // createAppColorPalette(); // (if you ever re-enable it)

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bilingual Buddy',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LandingPage(),
    );
  }
}
