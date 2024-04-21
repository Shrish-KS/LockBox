import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lockbox/services/auth.dart';
import 'package:lockbox/screens/chat/chattile.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  Widget build(BuildContext context) {
    final chats = Provider.of<List<ChatFriends>?>(context)??[];
    print(chats);
    return Container(
      child: ListView.builder(
          itemCount: chats.length,
          itemBuilder: (context,index){
            return ChatTile(chat :chats[index]);
          }
      ),
    );
  }
}
