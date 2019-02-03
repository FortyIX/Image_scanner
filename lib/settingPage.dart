
import 'package:flutter/material.dart';
import 'package:image_scanner/setting.dart';




class SettingPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SettingPage();
  }
}





class _SettingPage extends State<SettingPage>{
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      theme: new ThemeData(
        primaryColor: Color.fromARGB(255, 21, 140, 134),

      ),
      title: "setting",
      home: new Scaffold(
        appBar: new AppBar(
          title: Text("Setting")
        ),
        body: new ListView(
          children: <Widget>[
            Card(
              child: new Container(
                decoration: new BoxDecoration(),
                child: new Column(
                  children: <Widget>[
                    new Container(

                      margin: EdgeInsets.only(left: 25.0),
                      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                      child: new Row(
                        children: <Widget>[
                          Text("Debug Mode",style: new TextStyle(fontWeight: FontWeight.bold),),
                          new SizedBox(width: 180),
                          Switch(value: GeneralSetting.debug_mode, onChanged: (_){
                            GeneralSetting.debug_mode = !GeneralSetting.debug_mode;
                          })
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}