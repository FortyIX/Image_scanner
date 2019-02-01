import 'dart:io';
import 'dart:async';
import 'dart:math';


import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

class AddProfilePage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _AddProfilePage();
  }
}


class _AddProfilePage extends State<AddProfilePage>{


  var pic = null;
  String info = '';


  TextEditingController nameController = new TextEditingController();
  TextEditingController courseController = new TextEditingController();

  @override
  Widget build(BuildContext context) {



    // TODO: implement build
    return MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.blueAccent,
          accentColor: Colors.white,
        ),

        title: "OCR",
        home:Scaffold(
            appBar: new AppBar(title: Text("Optical Character Recognition"),),
            body: new ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[

                    new SizedBox(height: 10),
                    new TextField(

                      decoration: InputDecoration(

                          hintText: "name"
                      ),
                      controller: nameController,
                    ),

                    new SizedBox(height: 10),
                    new TextField(
                      decoration: InputDecoration(

                          hintText: "course"
                      ),
                      controller: courseController,
                    ),

                    new Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: <Widget>[
                        new Container(
                            padding:EdgeInsets.all(8.0),
                            child: RaisedButton(
                              child: Text("Open Camera"),
                              color: Theme.of(context).accentColor,
                              elevation: 4.0,
                              splashColor: Colors.blueGrey,
                              onPressed: () => _openCamera(),
                            )


                        ),

                        new Container(
                          child:RaisedButton(
                            child: Text("Save Profile"),
                            color: Colors.redAccent,
                            elevation: 4.0,
                            splashColor: Colors.blueGrey,
                            onPressed: () => _openCamera(),
                          ),
                        )

                      ],
                    ),
                    new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        new ListTile(
                          leading: this.pic,
                          title: Text(this.info),
                        )
                      ],
                    )

                  ],
                )
              ],
            )
        )
    );
  }


  void _openCamera() async {

    var pic1= await ImagePicker.pickImage(source: ImageSource.camera);
//    var picData  = await pic1.readAsBytes();

    _detectText(pic1);



  }


  void _detectText(File image) async{
    final targetImage = image;
    final FirebaseVisionImage FVimage = FirebaseVisionImage.fromFile(image);

    // create the detecting instance from firebase
    final TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();


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
      this.info = text;
    });

  }


  void _setEditForm(List<TextLine> recognizedDataLine){

    nameController.text = recognizedDataLine[2].toString() + recognizedDataLine[3].toString();
    courseController.text = recognizedDataLine[5].toString();



  }



}


