import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
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
  print(user);
  final dir = Directory((Platform.isAndroid
      ? await getExternalStorageDirectory() //FOR ANDROID
      : await getApplicationSupportDirectory() //FOR IOS
  )!
      .path + '/$user/');
  print(dir);


  FirebaseStorage _storage = FirebaseStorage.instance;
  List file;

  Future _listofFiles(repo) async {
    var status=await Permission.manageExternalStorage.request();
    if(status.isDenied){
      file=["Storage access not granted"];
      return ;
    }


    String directory = (Platform.isAndroid
        ? await getExternalStorageDirectory() //FOR ANDROID
        : await getApplicationSupportDirectory() //FOR IOS
    )!
        .path;
    print(directory);
    file = (repo=="")?Directory("$directory/$user/").listSync():Directory(repo+"/").listSync();

    file.forEach((element) async{
      File file=File(element.path);
      Reference reference = (repo=="")?_storage.ref().child("$user/"):_storage.ref().child("$user/${basename(repo)}/");
      UploadTask uploadTask = reference.child("${basename(file.path)}").putFile(file);
      String location = await (await uploadTask).ref.getDownloadURL();
      print(location);
    });

  }
  _listofFiles(repo);
}