import 'package:flutter/material.dart';
import 'package:lockbox/screens/Home/home.dart';
import 'package:permission_handler/permission_handler.dart';

class StoragePage extends StatefulWidget {
  const StoragePage({super.key});

  @override
  State<StoragePage> createState() => _StoragePageState();
}

class _StoragePageState extends State<StoragePage> {

  void _getpermission() async{
    await Permission.manageExternalStorage.request();
    bool isShown = await Permission.manageExternalStorage.shouldShowRequestRationale;
    if (await Permission.manageExternalStorage.request().isGranted) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage()),);
    }
  }

  void initState(){
    super.initState();
    _getpermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: (){
            openAppSettings();
          },
          child: Text("Get Storage Permission"),
        ),
      ),
    );
  }
}
