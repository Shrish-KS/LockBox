import 'package:flutter/material.dart';
import 'package:lockbox/screens/Authentication/signin.dart';
import 'package:lockbox/screens/localauth.dart';
import 'package:lockbox/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with WidgetsBindingObserver {

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  AppLifecycleState curstate = AppLifecycleState.inactive;
  LocalAuth check=LocalAuth();
  String user="";

  void initState() {
    super.initState();
    check.getAvailableBiometrics();
    WidgetsBinding.instance.addObserver(this);
    if (WidgetsBinding.instance.lifecycleState != null) {
      curstate=WidgetsBinding.instance.lifecycleState!;
    }
    _prefs.then((SharedPreferences prefs) {
      setState(() {
        user=prefs.getString("userin") ?? "";
      });
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      curstate=WidgetsBinding.instance.lifecycleState!;
      if(!check.justauth && curstate==AppLifecycleState.resumed){
        check.getAvailableBiometrics();
      }
      else if(curstate==AppLifecycleState.resumed){
        check.justauth=false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main page"),
        actions: [
          TextButton.icon(
              onPressed: () async{
                dynamic result=await Authenticate().signout();
                if(!(result is String)){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  SignIn(),));
                }
              },
              icon: Icon(
                  Icons.person,
                color: Colors.white,
              ),
              label: Text(
                  "Logout",
                style: TextStyle(
                  color: Colors.white
                ),
              )
          )
        ],
      ),
      body: Center(child:Text(curstate.toString()+user))
    );
  }
}

