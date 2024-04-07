import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

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
  suffixIconColor: MaterialStateColor.resolveWith((states) =>
  states.contains(MaterialState.focused)
      ? Colors.purple
      : Colors.grey),
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

const authheadingtext = TextStyle(
    fontSize: 30,
    color: Colors.white,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.9,
    wordSpacing: 1
);

ButtonStyle authbuttonstyle = ButtonStyle(
  shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
  side: MaterialStatePropertyAll(BorderSide()),
  backgroundColor: MaterialStatePropertyAll(Color.fromRGBO(90, 1, 91, 1.0)),
  foregroundColor: MaterialStatePropertyAll(Colors.white),
  textStyle: MaterialStatePropertyAll(TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.7
  )),
);


// alert dialog
var alertdialog = (context,title,widget,cancel,btntext,btntap, {customassets}){
  QuickAlert.show(
      context: context,
      type: QuickAlertType.custom,
      title: title,
      widget: widget,
      showCancelBtn: cancel,
      confirmBtnText: btntext,
      confirmBtnColor: Color.fromRGBO(90, 1, 91, 1.0),
      confirmBtnTextStyle: TextStyle(
          color: Colors.white
      ),
      onConfirmBtnTap: btntap,
      disableBackBtn: true,
      customAsset: customassets,
  );
};