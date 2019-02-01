import 'dart:io';
import 'dart:async';
import 'dart:math';


import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';


void main() => runApp(Test());

class Test extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _TestState();
  }
}


class _TestState extends State<Test>{

  var pic = null;
  String info = '';

  @override
  Widget build(BuildContext context) {



    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.lightBlue,
        accentColor: Colors.white,
      ),
      
      title: "OCR",
      home:Scaffold(
        appBar: new AppBar(title: Text("Optical Character Recognition"),),
      body: new ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              new Center(
                child: RaisedButton(
                  child: Text("Press"),
                  color: Theme.of(context).accentColor,
                  elevation: 4.0,
                  splashColor: Colors.blueGrey,
                  onPressed: () => openCamera(),
                ),
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


  void openCamera() async {

    var pic1= await ImagePicker.pickImage(source: ImageSource.camera);
//    var picData  = await pic1.readAsBytes();

    detectText(pic1);



  }
  
  
  void detectText(File image) async{
    final targetImage = image;
    final FirebaseVisionImage FVimage = FirebaseVisionImage.fromFile(image);

    // create the detecting instance from firebase
    final TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();

    
    final VisionText visionText = await textRecognizer.detectInImage(FVimage);

    int i=0;
    String text = visionText.text;
    for (TextBlock block in visionText.blocks) {
      i++;
      final Rectangle<int> boundingBox = block.boundingBox;
      final List<Point<int>> cornerPoints = block.cornerPoints;
      final String text = block.text;
      final List<RecognizedLanguage> languages = block.recognizedLanguages;

      for (TextLine line in block.lines) {
        print(line.text + " "+"with counter:" + " " + i.toString());


        for (TextElement element in line.elements) {
          // Same getters as TextBlock
        }
      }
    }

      setState(() {
        this.info = text;
      });


    
  } 
  
  

}





