import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lockbox/screens/Authentication/getstorageperm.dart';
import 'package:lockbox/screens/Authentication/signin.dart';
import 'package:lockbox/screens/Home/home.dart';
import 'package:lockbox/screens/loading.dart';
import 'package:lockbox/screens/onboarding/onboard.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:lockbox/screens/Home/notconnected.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {

  bool status=true;

  Future getwidget() async{
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          status=true;
        });
      }
    }catch (_) {
      setState(() {
        status=false;
      });
    };
  }

  void _checkperm() async {
    if(await Permission.manageExternalStorage.isDenied){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  StoragePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    getwidget();
    final user=Provider.of<User?>(context);
    if(user==null){
      return status?Onboard():NotConnected();
    }
    else{
      _checkperm();
      return MainPage();
    }
  }
}