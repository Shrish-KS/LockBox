import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:lockbox/screens/Authentication/signin.dart';
import 'package:lockbox/screens/Home/home.dart';
import 'package:lockbox/screens/loading.dart';
import 'package:lockbox/screens/onboarding/onboard.dart';
import 'package:lockbox/shared/constants.dart';
import 'package:quickalert/quickalert.dart';
import 'package:lockbox/services/auth.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final _formFieldKey = GlobalKey<FormFieldState>();
  Authenticate _auth = Authenticate();
  String email="";
  String pass="";
  String phone="";
  String checkpass="";
  String error="";
  DateTime dob=DateTime.now();
  String name="";
  bool loading=false;
  bool _passwordVisible=false;
  bool _passwordVisible2=false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: loading?Loading():Scaffold(
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
                        style: authheadingtext
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
                                  if(date==null ||date.year>2020){
                                    return "Enter valid Date of birth";
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
                                  obscureText: !_passwordVisible,
                                  decoration: textinputdecoration.copyWith(hintText: "Password",prefixIcon: Icon(Icons.key),label: Text("Password"),suffixIcon: IconButton(
                                    icon: Icon(
                                      _passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                  ),),
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
                                  obscureText: !_passwordVisible2,
                                  decoration: textinputdecoration.copyWith(hintText: "Confirm Password",prefixIcon: Icon(Icons.key),label: Text("Confirm Password"),suffixIcon: IconButton(
                                    icon: Icon(
                                      _passwordVisible2
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _passwordVisible2 = !_passwordVisible2;
                                      });
                                    },
                                  ),),
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
                                error,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 17
                                ),
                              ),
                              error.length!=0?SizedBox(height: 10,):Container(),
                              Container(
                                width: 150,
                                child: TextButton(
                                    style: authbuttonstyle,
                                    onPressed: () async{
                                      if( _formkey.currentState!.validate()){
                                        if(phone.length<10){
                                          setState(() {
                                            error="Enter Valid Mobile Number";
                                          });
                                        }
                                        else{
                                          setState(() {
                                            error="";
                                            loading=true;
                                          });
                                          dynamic result = await _auth.registerwithemailpass(email,pass,dob);
                                          if(result=="Old Email"){
                                            setState(() {
                                              loading=false;
                                            });
                                            alertdialog(context,"Old User?",Text("This email is already registered with us. Do you want to Sign In"),true,"Sign In",
                                                (){
                                                  Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(builder: (context) =>  SignIn()),
                                                  );
                                                }
                                            );
                                          }
                                          else if(result is String){
                                            setState(() {
                                              error=result;
                                              loading=false;
                                            });
                                          }
                                          else {
                                            setState(() {
                                              loading=false;
                                            });
                                            var alertwidget =Container(
                                              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                              child: TextFormField(
                                                decoration: textinputdecoration
                                                    .copyWith(label: Text(
                                                    "Display Name"),
                                                    hintText: "Display Name",
                                                    prefixIcon: Icon(Icons
                                                        .account_circle_outlined)),
                                                key: _formFieldKey,
                                                validator: (val) =>
                                                (val == null ||
                                                    val!.length < 3)
                                                    ? "Enter a Valid Name"
                                                    : null,
                                                onChanged: (val) {
                                                  name = val;
                                                },
                                              ),
                                            );
                                            alertdialog(context,"Enter Your Name",alertwidget,false,"Update",() {
                                            if (_formFieldKey.currentState!.validate()) {
                                            _auth.updatename(name, result);
                                            Navigator.push(context, MaterialPageRoute(builder: (context) =>  MainPage()),);
                                            }
                                            },
                                            customassets:'assets/namealert.png'
                                            );
                                          }
                                        }
                                        setState(() {
                                          loading=false;
                                        });
                                      }
                                    },

                                    child: Text("Register")
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
                                        Navigator.pushReplacement(
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
