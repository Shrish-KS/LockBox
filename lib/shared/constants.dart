import 'package:flutter/material.dart';

final textinputdecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
  filled: true,
  fillColor: Colors.grey[200],
  prefixIconColor: MaterialStateColor.resolveWith((states) =>
  states.contains(MaterialState.focused)
      ? Colors.purple
      : Colors.grey),
  floatingLabelStyle: TextStyle(
    color: Colors.purple[900]
  ),
  focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(
        color: Colors.red[300]??Colors.red,
        width: 2,
      )
  ),
  errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
        color: Colors.red[300]??Colors.red,
        width: 2,
      )
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
        color: Colors.grey,
        width: 2,
      )
  ),
  focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(
        color: Colors.purple,
        width: 2,
      )
  ),
);

final inputcontainerdecoration= BoxDecoration(
color: Colors.grey[300],
borderRadius: BorderRadius.all(Radius.circular(20))
);