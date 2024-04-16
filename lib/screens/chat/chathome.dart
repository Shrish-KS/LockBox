import 'package:flutter/material.dart';
import 'package:lockbox/screens/chat/chatlist.dart';
import 'package:lockbox/shared/constants.dart';
import 'package:lockbox/services/auth.dart';
import 'package:provider/provider.dart';

class ChatMain extends StatefulWidget {
  const ChatMain({super.key});

  @override
  State<ChatMain> createState() => _ChatMainState();
}

class _ChatMainState extends State<ChatMain> {

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String name="";
  String result="";

  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      initialData: null,
      value: Authenticate().friends,
      child: Scaffold(
        appBar: AppBar(title: Text("Chatpage"),),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _displayDialog(context);
          },
        ),
        body: Container(
        child: ChatList()
        ),
      ),
    );
  }


  _displayDialog(context) {
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
          "Enter Email address of friend",
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
              key: _formkey,
              child: TextFormField(
                maxLines: 1,
                autofocus: false,
                keyboardType: TextInputType.text,
                decoration: textinputdecoration.copyWith(hintText: "Friend Email",label: Text("Friend Email"),prefixIcon: Icon(Icons.email_outlined)),
                onChanged: (val){
                  name=val;
                },
                validator: (val)=>(val=="")?"Email can't be empty": ((result=="")?null:result),
              ),
            )
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            TextButton(
              onPressed: () {
                result="";
                name="";
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
                "Save",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () async{
                if(name!="") {
                  result=await Authenticate().addFriendlist(name);
                  if (result=="") {
                  }
                  print(result);
                }
                if(_formkey.currentState!.validate()){
                  name="";
                  print("deidiehiehd");
                  Navigator.of(context).pop();
                }
              },
            )
          ],
        ),
      ],
    ),
  );

}
