import 'package:flutter/material.dart';
import 'package:image_scanner/addProfile.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_scanner/ProfileInstance.dart';


class MainPageWidget extends StatefulWidget {

 @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MainPageWidget();
  }

}


class _MainPageWidget extends State<MainPageWidget>{

  List<ProfileInstance> data = [];

   @override
  void initState() {
    // TODO: implement initState

     DatabaseReference database_ref = FirebaseDatabase.instance.reference();
     database_ref.child("kcl_robotics_attendance").once().then((DataSnapshot snap){
       var keys = snap.value.keys;
       var data_instance = snap.value;

       for (var key in keys){

         ProfileInstance tmp = new ProfileInstance(
             data_instance[key]['name'], data_instance[key]['course']
         );
         setState(() {
           this.data.add(tmp);
         });

       }

       print("Length"+this.data.length.toString());
       print("running here1 ");

     });



     super.initState();

  }



  @override
   Widget build(BuildContext context) {

     print("running2");
       return new MaterialApp(
           theme: ThemeData(
               primaryColor: Colors.blueAccent,
               accentColor: Colors.white,
                ),
           title: "home_page",
           home: new Scaffold(
             drawer: _createDrawer(),
             appBar: new AppBar(
               title: new Text("Home Page"),
               actions: <Widget>[
                 new FlatButton(onPressed: null, child: null)
               ],
             ),
             body: new Container(
               child: this.data.length == 0 ? new Text("Downloading") :
               new ListView.builder(itemBuilder: (_,index){

                 return createCard(this.data[index].name, this.data[index].course);


               }, itemCount: this.data.length),
             ),

           )
       );
    }


  Widget _makeList(String name, String course){

    return new ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 30.0,vertical: 10.0),
      title: Text(name),
      leading: Container(
        padding: EdgeInsets.only(right: 35.0),
        decoration: new BoxDecoration(
          border: new Border(
            right: new BorderSide(width: 1.0,color: Colors.black)
          ),
        ),
        child: new Column(
          children: <Widget>[
            new Text("Day"),
            new Text("Month")
          ],
        ),
      ),

      subtitle: Text(course),
    );
  }




    Widget createCard(String name, String course){

         return new Card(
           elevation: 8.0,
           margin: new EdgeInsets.symmetric(horizontal: 10.0,vertical: 9.0),
           child: new Container(
             decoration: BoxDecoration(),
             child: _makeList(name,course),
             ),
           );
         

    }


    Widget _createDrawer(){

      return new Drawer(
        child: new ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text("Menu"),
              decoration: BoxDecoration(
                color: Colors.blue
              ),
            ),

            ListTile(
              title: Text("Add New Profile"),
              onTap: (){

                print("clicked");

                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AddProfilePage()));


              },
            )
          ],
        )
      );



    }











}









