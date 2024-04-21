import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lockbox/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:lockbox/screens/chat/userchatpage.dart';

class ChatTile extends StatefulWidget {
  ChatFriends? chat;
  ChatTile({this.chat});

  @override
  State<ChatTile> createState() => _ChatTileState();
}

class _ChatTileState extends State<ChatTile> {
  @override
  Widget build(BuildContext context) {
    print(widget.chat!.displayname);
    return FutureBuilder(
        future: FlutterSecureStorage().read(key:widget.chat!.uid),
        builder: (BuildContext context, snapshot){
          if(snapshot.hasData) {
            return Padding(
                padding: EdgeInsets.only(top: 8),
                child: Card(
                  margin: EdgeInsets.fromLTRB(10, 6, 20, 0),
                  child: TextButton(
                    onPressed: (){
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) =>  UserChat()),
                      );
                    },
                    child:ListTile(
                      title: Text(
                        snapshot.data??"",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  )
                )
            );
          }
          else{
            return Text("fi");
          }
        });
  }
}
