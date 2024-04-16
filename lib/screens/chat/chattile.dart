import 'package:flutter/material.dart';
import 'package:lockbox/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatTile extends StatefulWidget {
  ChatFriends? chat;
  ChatTile({this.chat});

  @override
  State<ChatTile> createState() => _ChatTileState();
}

class _ChatTileState extends State<ChatTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8),
        child: Card(
          margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
          child: ListTile(
            title: Text(widget.chat!.uid),
          ),
        )
    );
  }
}
