import 'package:flutter/material.dart';
import 'package:image_scanner/addProfile.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';


class MainPageWidget extends StatefulWidget {

 @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MainPageWidget();
  }

}


class _MainPageWidget extends State<MainPageWidget>{
  @override
   Widget build(BuildContext context) {
       return new MaterialApp(
           theme: ThemeData(
               primaryColor: Colors.blueAccent,
               accentColor: Colors.white,
                ),
           title: "home_page",
           home: new Scaffold(
             appBar: new AppBar(
               title: new Text("Home Page"),
               
             ),

           )
       );
    }
}









