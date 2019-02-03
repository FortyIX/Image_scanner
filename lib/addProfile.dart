import 'dart:io';
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';


import 'package:image_scanner/setting.dart';


class AddProfilePage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {

    return new _AddProfilePage();
  }
}


class _AddProfilePage extends State<AddProfilePage> {


  String course_name = '';
  String profile_name = '';
  String day = '';
  String month = '';
  //String weekDay = '';


  DatabaseReference database_ref = FirebaseDatabase.instance.reference();

  String info = '';


  TextEditingController nameController = new TextEditingController();
  TextEditingController courseController = new TextEditingController();

  @override
  Widget build(BuildContext context) {


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
                                       hintText: "name"
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
                                       hintText: "course"
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
                                                  onPressed: () => _openCamera(),
                                               )


                                            ),

                                         new Container(
                                              child: RaisedButton(
                                                  child: Text("Save Profile"),
                                                  color: Colors.redAccent,
                                                  elevation: 4.0,
                                                  splashColor: Colors.blueGrey,
                                                  onPressed: () => _submitData()
                                              ),
                                           )

                                    ],
                                 ),
                               new Column(
                                   mainAxisAlignment: MainAxisAlignment.start,
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: <Widget>[

                                       new ListTile(

                                          title: Text(this.info),
                                         )

                                   ],
                                )

                  ],
                )

            )
        )
      ]
     )
     )
    );
  }


  // configure the output of the information
  void _setEditForm(List<TextLine> recognizedDataLine) {
    if(recognizedDataLine.length < 2){
      Util.triggerSimpleDialog(context, "Poor Capture ", "The image you captured does not contain enough information, please retry", "Close");
    }
    else{
      nameController.text =
          recognizedDataLine[0].text + "  " + recognizedDataLine[1].text;
      courseController.text = recognizedDataLine[3].text;

    }
  }


  // open camera intent and return a picture followed by calling function to analysing the image
  void _openCamera() async {
    var pic1 = await ImagePicker.pickImage(source: ImageSource.camera);
   //    var picData  = await pic1.readAsBytes();

     _detectText(pic1);
  }



// Detect the texts in the image and call function to dispaly the information for recording/debugging
  void _detectText(File image) async {

    final targetImage = image;
    final FirebaseVisionImage FVimage = FirebaseVisionImage.fromFile(image);

    // create the detecting instance from firebase
    final TextRecognizer textRecognizer = FirebaseVision.instance
        .textRecognizer();


    final VisionText visionText = await textRecognizer.detectInImage(FVimage);

     int i =0;
     int j = 0;

    String text = visionText.text;
    for (TextBlock block in visionText.blocks) {
      i = i+ 1;
      final Rectangle<int> boundingBox = block.boundingBox;
      final List<Point<int>> cornerPoints = block.cornerPoints;
      final String text = block.text;
      final List<RecognizedLanguage> languages = block.recognizedLanguages;



      for (TextLine line in block.lines) {
        j= j+ 1;
        print(line.text + " "+"with black:" + " " + i.toString() + " "+"with Line"+ " "+j.toString());


        for (TextElement element in line.elements) {
          // Same getters as TextBlock
        }
      }
    }

      setState(() {
        if(GeneralSetting.debug_mode) {
          this.info = text;
        }

        if(visionText.blocks.length<1){
          Util.triggerSimpleDialog(context, "Poor Capture ", "The image you captured does not contain enough information, please retry", "Close");
        }
        else {
          _setEditForm(visionText.blocks[1].lines);
        }
      });
    }


    // upload the data in the inputfield to the database
    void _submitData(){

       this.day = DateTime.now().day.toString();
       this.month = DateTime.now().month.toString();
       this.course_name = this.courseController.text;
       this.profile_name = this.nameController.text;


       _uploadProfile();


    }






    void _uploadProfile(){

      var tobeUploadeddata = {
        "name":profile_name,
        "course":course_name,
        "day":day,
        "month":month,
      };

      if(_vaildateInput()) {
        database_ref.child('kcl_robotics_attendance_with_time').push().set(
            tobeUploadeddata);
      }
      else{
        Util.triggerSimpleDialog(context, "Invaild Input", "Please fill in both input field properly", "Close");
      }

    }



    bool _vaildateInput(){

       return  (profile_name != ' ' && course_name != ' ' );

    }


  }


