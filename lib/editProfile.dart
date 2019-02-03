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
  TextEditingController dayController = new TextEditingController();
  TextEditingController monthController = new TextEditingController();

  String new_name  = "";
  String new_course  = "";
  String new_day  = "";
  String new_month  = "";


  DatabaseReference database_ref = FirebaseDatabase.instance.reference();

  final updateSnackBar = SnackBar(
    content: Text("Updated Sucessfully"),
  );

  final delSnackBar = SnackBar(
    content: Text("Updated Sucessfully"),
  );


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
            appBar: new AppBar(title: Text("Edit Profile"),),
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
                                  controller: dayController,
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
                                  controller: monthController,
                                ),
                              ),



                              new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Container(
                                      padding: EdgeInsets.all(8.0),
                                      child: RaisedButton(
                                        child: Text("Update"),
                                        color: Theme.of(context).accentColor,
                                        elevation: 4.0,
                                        splashColor: Colors.blueGrey,
                                        onPressed: () => _onSubmit(context),
                                      )


                                  ),

                                  new Container(
                                    child: RaisedButton(
                                        child: Text("Delete Profile"),
                                        color: Colors.redAccent,
                                        elevation: 4.0,
                                        splashColor: Colors.blueGrey,
                                        onPressed: () => _onDelete(context)
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




  void _onSubmit(BuildContext context){

    this.new_name = nameController.text;
    this.new_course = courseController.text;
    this.new_day = dayController.text;
    this.new_month = monthController.text;

    _updateData(context);

  }


  void _onDelete(BuildContext context){
    _delData(context);
  }

  void _updateData(BuildContext context){

    database_ref.child("kcl_robotics_attendance_with_time"+"/"+widget.store.key).set({
        'name': this.new_name,
        'course': this.new_course,
        'day': this.new_day,
        'month': this.new_month
    }).then((_){
      Scaffold.of(context).showSnackBar(updateSnackBar);
    });

  }



   void _delData(BuildContext context){
     database_ref.child("kcl_robotics_attendance_with_time"+"/"+widget.store.key).remove().then((_){

       Scaffold.of(context).showSnackBar(delSnackBar);
     });

   }




  }












