// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intellibox/modules/home/screens/home.dart';
import 'package:intellibox/utils/theme.dart';

// import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: STheme.normal,
      home: HomePage(),
    );
  }
}
