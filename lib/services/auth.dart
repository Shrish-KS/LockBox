import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class Authenticate{
  final FirebaseAuth _auth= FirebaseAuth.instance;

  Future signinwithemailpass(String email,String password) async{
    try {
      final user = await _auth.signInWithEmailAndPassword(email: email, password: password);
      print(user);
      return user;
    }
    catch(e){
      if(e.hashCode==144434344){
        return "New email";
      }
      return e.toString();
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
      print(e);
      return e.toString();
    }
  }

  Future updatename(String name,User? user) async{
    try {
      await user!.updateDisplayName(name);
      return name;
    }
    catch(e){
      return e.toString();
    }
  }

}