import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<String> createFolder(String cow) async {
  final dir = Directory((Platform.isAndroid
      ? await getExternalStorageDirectory() //FOR ANDROID
      : await getApplicationSupportDirectory() //FOR IOS
  )!
      .path + '/$cow');
  if ((await dir.exists())) {
    return dir.path;
  } else {
    dir.create();
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