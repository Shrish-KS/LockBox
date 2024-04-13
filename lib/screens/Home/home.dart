import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:lockbox/screens/Authentication/signin.dart';
import 'package:lockbox/screens/Home/displayrepos.dart';
import 'package:lockbox/screens/localauth.dart';
import 'package:lockbox/screens/pdfview.dart';
import 'package:lockbox/services/auth.dart';
import 'package:lockbox/shared/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:lockbox/services/directory.dart';
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
  String name="";
  String extpath="";

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

  _displayDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            elevation: 6,
            backgroundColor: Colors.transparent,
            child: _DialogWithTextField(context),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
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
      body: Center(
          child: Column(
            children: [
              Text(curstate.toString()+user+name+extpath),
              Form(
                  child: Column(
                    children: [
                      TextButton(
                          onPressed: () async{
                            FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom,allowedExtensions: ["pdf"]);

                            if (result != null) {
                              File file = File(result.files.single.path!);
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>  PDFview(file:file)),);
                              setState(() {
                                name=file.toString();
                              });
                            } else {
                              // User canceled the picker
                            }
                          },
                          child: Text("Enter")
                      ),
                      TextButton(
                          onPressed: () async{
                            String result=await createFolder(user);
                            if(result!=null){
                              setState(() {
                                extpath=result;
                              });
                            }
                          },
                          child: Text("EEEEEE")
                      ),
                      TextButton(
                          onPressed: _displayDialog,
                          child: Text("Create")
                      ),
                      TextButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DisplayRepo("")),);
                        },
                        child: Text("Create folder"),
                      )
                    ],
                  )
              )
            ],
          )
      )
    );
  }

  Widget _DialogWithTextField(BuildContext context) => Container(
    height: 210,
    decoration: BoxDecoration(
      color:  Colors.white,
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    child: Column(
      children: <Widget>[
        SizedBox(height: 24),
        Text(
          "Enter new Directory name",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        SizedBox(height: 10),
        Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10, right: 15, left: 15),

            child: Form(
                child: TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    keyboardType: TextInputType.text,
                    decoration: textinputdecoration.copyWith(hintText: "Directory Name",label: Text("Directory Name"),prefixIcon: Icon(Icons.folder_copy_outlined))
                )
            )
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(width: 8),
            TextButton(
              style: authbuttonstyle.copyWith(textStyle: MaterialStatePropertyAll(TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.6
              ))),
              child: Text(
                "Save".toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                print('Update the user info');
              },
            )
          ],
        ),
      ],
    ),
  );
}