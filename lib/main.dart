import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qoute_app/Model/qoute.dart';
import 'package:qoute_app/View/pages/HomePage.dart';
import 'package:qoute_app/View/pages/splash.dart';

void main() {
  debugProfilePaintsEnabled = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}
