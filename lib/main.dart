import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lockbox/screens/Authentication/register.dart';
import 'package:lockbox/screens/onboarding/onboard.dart';
import 'package:lockbox/screens/Authentication/signin.dart';
import 'package:lockbox/screens/loading.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Onboard(),
    );
  }
}
