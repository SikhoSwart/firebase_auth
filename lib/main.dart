import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  // Required to interact with the engine before UI renders
  WidgetsFlutterBinding.ensureInitialized();

  // Connects to Firebase project
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Auth App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Wrapper(), // The Wrapper dictates the starting screen
    );
  }
}