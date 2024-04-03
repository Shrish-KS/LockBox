import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:lockbox/screens/Authentication/signin.dart';
import 'package:lockbox/screens/onboarding/onboard.dart';
import 'package:lockbox/shared/constants.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final _formFieldKey = GlobalKey<FormFieldState>();
  String email="";
  String pass="";
  String phone="";
  String checkpass="";
  bool error=false;
  String errormessage="";
  DateTime dob=DateTime.now();

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
                        "Create Account",
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
                              SizedBox(height: 15,),
                              Container(
                                child: TextFormField(
                                  decoration: textinputdecoration.copyWith(hintText: "Email",prefixIcon: Icon(Icons.email_outlined),label: Text("Email")),
                                  validator: (val) => val!.length==0?"Email cant be empty":null,
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
                              SizedBox(height: 20,),
                              Container(
                                child: IntlPhoneField(
                                  decoration: textinputdecoration.copyWith(hintText: "Phone",label: Text("Phone")),
                                  initialCountryCode: 'IN',
                                  onChanged: (val) {
                                    phone=val!.completeNumber;
                                  },
                                  disableAutoFillHints: true,
                                ),
                              ),
                              SizedBox(height: 10,),
                              DateTimeFormField(
                                validator: (date) {
                                  if(date==null){
                                    return "Enter valid date";
                                  }
                                  else if(date.year>2020){
                                    return "Enter Your Date of birth";
                                  }
                                  else{
                                    return null;
                                  }
                                },
                                decoration: textinputdecoration.copyWith(label: Text("Birthday"),prefixIcon: Icon(Icons.cake_rounded),suffixIcon: Icon(Icons.calendar_month)),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2030),
                                onDateSelected: (date){
                                  dob=date;
                                },
                                mode: DateTimeFieldPickerMode.date,
                              ),
                              SizedBox(height: 20,),
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
                                child: TextFormField(
                                  decoration: textinputdecoration.copyWith(hintText: "Password",prefixIcon: Icon(Icons.key),label: Text("Password")),
                                  validator: (val){
                                    if(val==null || val.length<6){
                                      return "Password should be atleast 6 charecters";
                                    }
                                    else if(checkpass!=pass){
                                      return "Passwords Do not match";
                                    }
                                    else { return null;}
                                  },
                                  onChanged: (val) =>{
                                    checkpass=val
                                  },
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.brown[600],
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                              SizedBox(height: 15,),
                              Text(
                                  errormessage,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 17
                                ),
                              ),
                              error?SizedBox(height: 10,):Container(),
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
                                      if( _formkey.currentState!.validate()){
                                        if(phone.length<10){
                                          setState(() {
                                            error=true;
                                            errormessage="Enter Valid Mobile Number";
                                          });
                                        }
                                        else{
                                          setState(() {
                                            error=false;
                                            errormessage="";
                                          });
                                        }
                                        print(email);
                                        print(pass);
                                        print(phone);
                                        print(checkpass);
                                        print(dob);
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
                                    Text("Already have an account  "),
                                    InkWell(
                                      child: Text(
                                        "Sign In",
                                        style: TextStyle(
                                          color: Colors.red[700],
                                        ),
                                      ),
                                      onTap: (){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) =>  SignIn()),
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
              ),
          )
      ),
    );
  }
}
