import 'package:flutter/material.dart';
import 'package:lockbox/screens/Authentication/register.dart';
import 'package:lockbox/screens/onboarding/onboard.dart';
import 'package:lockbox/shared/constants.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String email="";
  String pass="";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/gradient.png"),
                  fit: BoxFit.cover
              )
          ),
          child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Welcome Back!",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.9,
                      wordSpacing: 1
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(25))
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 25,vertical: 20),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          SizedBox(height: 20,),
                          Container(
                            child: TextFormField(
                              decoration: textinputdecoration.copyWith(hintText: "Email/Phone",prefixIcon: Icon(Icons.person),label: Text("Email/Phone")),
                              validator: (val) => val!.length==0?"Email/phone cant be empty":null,
                              onChanged: (val) =>{
                                email=val
                              },
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.brown[600],
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          SizedBox(height: 30,),
                          Container(
                            child: TextFormField(
                              decoration: textinputdecoration.copyWith(hintText: "Password",prefixIcon: Icon(Icons.key),label: Text("Password")),
                              validator: (val) => val!.length<6?"Password should be atleast 6 charecters":null,
                              onChanged: (val) =>{
                                pass=val
                              },
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.brown[600],
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                          Container(
                            width: 150,
                            child: TextButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
                                side: MaterialStatePropertyAll(BorderSide()),
                                backgroundColor: MaterialStatePropertyAll(Color.fromRGBO(
                                    90, 1, 91, 1.0)),
                                foregroundColor: MaterialStatePropertyAll(Colors.white),
                                textStyle: MaterialStatePropertyAll(TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.7
                                )),
                              ),
                                onPressed: (){
                                  if(_formkey.currentState!.validate()){
                                    print(email);
                                    print(pass);
                                  }
                                },
                                child: Text("Login")
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Dont have an account  "),
                                InkWell(
                                  child: Text(
                                      "Register",
                                    style: TextStyle(
                                      color: Colors.red[700],
                                    ),
                                  ),
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) =>  Register()),
                                    );
                                  },
                                )
                              ],
                            ),

                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        )
      ),
    );
  }
}
