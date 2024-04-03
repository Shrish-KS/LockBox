import 'package:flutter/material.dart';
import 'package:lockbox/screens/Authentication/register.dart';
import 'package:lockbox/screens/onboarding/onboard.dart';
import 'package:lockbox/screens/Authentication/signin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Register(),
    );
  }
}
