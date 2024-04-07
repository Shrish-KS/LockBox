import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lockbox/screens/Authentication/register.dart';
import 'package:lockbox/screens/Home/home.dart';
import 'package:lockbox/screens/localauth.dart';
import 'package:lockbox/screens/onboarding/onboard.dart';
import 'package:lockbox/screens/Authentication/signin.dart';
import 'package:lockbox/screens/loading.dart';
import 'package:lockbox/screens/wrapper.dart';
import 'package:lockbox/services/auth.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
        initialData: null,
        value: Authenticate().user,
        child: MaterialApp(home:Wrapper())
    );
  }
}
