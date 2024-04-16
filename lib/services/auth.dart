import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lockbox/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authenticate {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference emaildata = FirebaseFirestore.instance.collection(
      "email");
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final CollectionReference frienddata = FirebaseFirestore.instance.collection(
      "friends");
  final uid = FirebaseAuth.instance.currentUser!.uid;

  Future signout() async {
    try {
      final SharedPreferences prefs = await _prefs;
      await prefs.setString('userin', "");
      print("signed out");
      await _auth.signOut();
      return;
    }
    catch (e) {
      print(e);
      return e.toString();
    }
  }

  Future signinwithemailpass(String email, String password) async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (user != null) {
        final SharedPreferences prefs = await _prefs;
        await prefs.setString('userin', user.user!.email ?? "");
      }
      return user;
    }
    catch (e) {
      if (e.toString() ==
          "[firebase_auth/invalid-credential] The supplied auth credential is incorrect, malformed or has expired.") {
        bool newemail = true;
        await emaildata.where("email", isEqualTo: email).get().then((value) =>
        {
          newemail = (value.docs.length == 0)
        });
        if (newemail) {
          return "New email";
        }
        else {
          return "Invalid Credentials";
        }
      }
      return "Enter valid Email";
    }
  }

  Future registerwithemailpass(String email, String password,
      DateTime dob) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      if (user != null) {
        final SharedPreferences prefs = await _prefs;
        await prefs.setString('userin', user!.email ?? "");
        emaildata.doc(uid).set({"email": user.email, "DOB": dob});
        frienddata.doc(uid).set({
          "friends": []
        });
      }
      print(user);
      return user;
    }
    catch (e) {
      print(e.toString());
      if (e.toString() ==
          "[firebase_auth/email-already-in-use] The email address is already in use by another account.") {
        return "Old Email";
      }
      return e.toString();
    }
  }

  Future updatename(String name, User? user) async {
    try {
      await user!.updateDisplayName(name);
      return name;
    }
    catch (e) {
      return e.toString();
    }
  }

  Stream<User?> get user {
    return _auth.authStateChanges();
  }

  Future addFriendlist(String friendemail) async {
    if (_auth.currentUser!.email == friendemail) {
      return "You can't add yourself";
    }
    List<QueryDocumentSnapshot> db = [];
    await emaildata.where("email", isEqualTo: friendemail).get().then((value) =>
    {
      db = value.docs
    });
    if (db.isEmpty) {
      return "Entered email is not registered";
    }
    else {
      Map data = {"friends": [], "bothadded": [], "otheradded": []} as Map;
      await frienddata.doc(uid).get().then((value) {
        data = (value.data() ??
            {"friends": [], "bothadded": [], "otheradded": []}) as Map;
      });
      if (data["bothadded"] != null && data["bothadded"].contains(db[0].id)) {
        return "Friend Already added";
      }
      else if (data["friends"] != null && data["friends"].contains(db[0].id)) {
        return "You have added already the friend";
      }
      else
      if (data["otheradded"] != null && data["otheradded"].contains(db[0].id)) {
        data["otheradded"].removeWhere((item) => item == db[0].id);
        data["bothadded"].add(db[0].id);
      }
      else {
        data["friends"] = data["friends"];
        data["friends"].add(db[0].id);
      }
      await frienddata.doc(uid).set({
        "friends": data["friends"],
        "bothadded": data["bothadded"],
        "otheradded": data["otheradded"]
      });
    }
    return "";
  }

  List<ChatFriends> converttouid(DocumentSnapshot snap){
    try {
      return (snap.data() as Map)!["bothadded"]!.forEach((val) {
        return ChatFriends(val);
      }).toList();
    }
    catch(e){
      print(e);
      return [];
    }
  }

  Stream<List<ChatFriends>> get friends{
    return frienddata.doc(uid).snapshots().map(converttouid);
  }
}

class ChatFriends{
  String uid="";
  ChatFriends(this.uid);
}