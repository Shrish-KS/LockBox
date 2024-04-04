import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/gradient.png"),
                fit: BoxFit.cover
            )
        ),
        child: SpinKitFadingCircle(
          color: Colors.purple[200],
          size: 60,
        ),
      ),
    );
  }
}
