import 'package:flutter/material.dart';

class Util {

  static void triggerSimpleDialog(BuildContext con, String title, String content,String close_msg){
    showDialog(context: con,
    barrierDismissible: true,
    builder: (BuildContext context){
      return AlertDialog(
        title: new Text(title),
        content: new Text(content),
        actions: <Widget>[
          new FlatButton(onPressed: null, child: null)
        ],
      
      );

     }
    );
  }
}