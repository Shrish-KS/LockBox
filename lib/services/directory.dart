import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';

Future<String> createFolder(String cow) async {
  final dir = Directory((Platform.isAndroid
      ? await getExternalStorageDirectory() //FOR ANDROID
      : await getApplicationSupportDirectory() //FOR IOS
  )!
      .path + '/$cow/');
  print(dir);
  if ((await dir.exists())) {
    return dir.path;
  } else {
    dir.create(recursive: true);
    return dir.path;
  }
}

Future checkFolder(String cow) async {
  final dir = Directory((Platform.isAndroid
      ? await getExternalStorageDirectory() //FOR ANDROID
      : await getApplicationSupportDirectory() //FOR IOS
  )!
      .path + '/$cow');
  if ((await dir.exists())) {
    return false;
  } else {
    dir.create();
    return true;
  }
}

Future uploadfolder(repo) async{
  String user="";
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  await _prefs.then((SharedPreferences prefs) {
    user=prefs.getString("userin") ?? "";
  });
  FirebaseStorage _storage = FirebaseStorage.instance;
  List file;

  Future _listofFiles(repo) async {
    var status=await Permission.manageExternalStorage.request();
    if(status.isDenied){
      file=["Storage access not granted"];
      return ;
    }
    final uid=FirebaseAuth.instance.currentUser!.uid;
    String directory = (Platform.isAndroid
        ? await getExternalStorageDirectory() //FOR ANDROID
        : await getApplicationSupportDirectory() //FOR IOS
    )!
        .path;
    file = (repo=="")?Directory("$directory/$user/").listSync():Directory(repo+"/").listSync();
    CollectionReference curstore=FirebaseFirestore.instance.collection("shareddata").doc(uid).collection("Uploadedfiles");
    var docid;
    await curstore.add({"name":"${basename(repo)}"}).then((doc) => docid=doc.id);
    Reference reference = (repo=="")?_storage.ref().child("$uid/"):_storage.ref().child("$uid/$docid/");

    file.forEach((element) async{
      File file=File(element.path);
      UploadTask uploadTask = reference.child("${basename(file.path)}").putFile(file);
    });

  }
  _listofFiles(repo);
}