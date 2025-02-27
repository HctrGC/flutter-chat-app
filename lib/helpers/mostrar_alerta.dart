import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

mostrarAlerta(BuildContext context, String titulo, String subtitulo) {

  // if (Platform.isAndroid) {
    return showDialog(
      context: context, 
      builder: (_) => AlertDialog(
        title: Text(titulo, textAlign: TextAlign.center),
        content: Text(subtitulo, textAlign: TextAlign.center),
        actions: [
          MaterialButton(
            onPressed: () {Navigator.of(context).pop();},
            elevation: 5,
            textColor: Colors.blue,
            child: const Text("Ok")
          )
        ]
      )
    );
  // } 

  // showCupertinoDialog(
  //   context: context, 
  //   builder: (_) => CupertinoAlertDialog(
  //     title: Text(titulo),
  //     content: Text(subtitulo),
  //     actions: [
  //       CupertinoDialogAction(
  //         isDefaultAction: true,
  //         onPressed: () {Navigator.of(context).pop();},
  //         child: const Text("Ok")
  //       )
  //     ]
  //   )
  // );  

}