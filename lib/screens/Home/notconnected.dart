import 'package:flutter/material.dart';

class NotConnected extends StatefulWidget {
  const NotConnected({super.key});

  @override
  State<NotConnected> createState() => _NotConnectedState();
}

class _NotConnectedState extends State<NotConnected> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Not Connected"),
    );
  }
}
