import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Authenticate{
  final FirebaseAuth _auth= FirebaseAuth.instance;
  final CollectionReference emaildata = FirebaseFirestore.instance.collection("email");

  Future signinwithemailpass(String email,String password) async{
    try {
      final user = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return user;
    }
    catch(e){
      if(e.toString()=="[firebase_auth/invalid-credential] The supplied auth credential is incorrect, malformed or has expired.") {
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

  Future registerwithemailpass(String email,String password) async{
    try{
      final result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user=result.user;
      print(user);
      return user;
    }
    catch(e){
      print(e.toString());
      if(e.toString()=="[firebase_auth/email-already-in-use] The email address is already in use by another account."){
        return "Old Email";
      }
      return e.toString();
    }
  }

  Future updatename(String name,User? user) async{
    try {
      await user!.updateDisplayName(name);
      emaildata.add({"email":user.email});
      return name;
    }
    catch(e){
      return e.toString();
    }
  }

}