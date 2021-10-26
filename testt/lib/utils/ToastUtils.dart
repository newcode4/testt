import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showTaost(msg){
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 16.0
  );


}


