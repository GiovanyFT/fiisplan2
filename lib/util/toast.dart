import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// No Android 30 a customização não funcionou, mas aparece o Toast
// Até o 29 está ok, inclusive a customização
void MensagemAlerta(String msg){
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
  );
}