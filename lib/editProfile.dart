import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:image_scanner/mainPage.dart';
import 'package:image_scanner/ProfileInstance.dart';


class EditProfilePage extends StatefulWidget{

  ProfileInstance store;

  EditProfilePage({Key key, @required this.store}):super(key:key);



  @override
  State<StatefulWidget> createState() {
    return _EditProfilePage();
  }

}


class _EditProfilePage extends State<EditProfilePage>{


  TextEditingController nameController = new TextEditingController();
  TextEditingController courseController = new TextEditingController();






  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        theme: ThemeData(
          primaryColor: Color.fromARGB(255, 21, 140, 134),
          accentColor: Colors.white,
        ),

        title: 'OCR',
        home: Scaffold(
            appBar: new AppBar(title: Text("Add New Profile"),),
            body: new ListView(

                children: <Widget>[

                  new Card(
                      elevation: 8.0,
                      margin: new EdgeInsets.symmetric(horizontal: 10.0,vertical: 9.0),
                      child: new Container(
                          decoration: BoxDecoration(),
                          child: Column(
                            children: <Widget>[

                              new SizedBox(height: 10),
                              new Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: new TextField(
                                  decoration: InputDecoration(
                                      border: new OutlineInputBorder(),
                                      hintText: widget.store.name
                                  ),
                                  controller: nameController,
                                ),
                              ),

                              new SizedBox(height: 10),

                              new Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child:  new TextField(

                                  decoration: InputDecoration(

                                      border: new OutlineInputBorder(),
                                      hintText: widget.store.course
                                  ),
                                  controller: courseController,
                                ),
                              ),

                              new SizedBox(height: 10),

                              new Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child:  new TextField(

                                  decoration: InputDecoration(

                                      border: new OutlineInputBorder(),
                                      hintText: widget.store.day
                                  ),
                                  controller: courseController,
                                ),
                              ),


                              new SizedBox(height: 10),
                              new Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child:  new TextField(

                                  decoration: InputDecoration(

                                      border: new OutlineInputBorder(),
                                      hintText: widget.store.month
                                  ),
                                  controller: courseController,
                                ),
                              ),



                              new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Container(
                                      padding: EdgeInsets.all(8.0),
                                      child: RaisedButton(
                                        child: Text("Open Camera"),
                                        color: Theme.of(context).accentColor,
                                        elevation: 4.0,
                                        splashColor: Colors.blueGrey,
                                        onPressed: () => null,
                                      )


                                  ),

                                  new Container(
                                    child: RaisedButton(
                                        child: Text("Save Profile"),
                                        color: Colors.redAccent,
                                        elevation: 4.0,
                                        splashColor: Colors.blueGrey,
                                        onPressed: () => null
                                    ),
                                  )

                                ],
                              ),

                            ],
                          )

                      )
                  )
                ]
            )
        )
    );
  }















}