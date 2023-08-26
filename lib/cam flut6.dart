
import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:df/cam%20flut7.dart';
import 'package:df/predict_based_photo2.dart';
Future<void> main() async {
  runApp(MyCameraAppsix());
}

class MyCameraAppsix extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      home: MyCameraAppsixPage(),
    );
  }
}

class MyCameraAppsixPage extends StatefulWidget{
  @override
  _MyCameraAppsixState createState() => _MyCameraAppsixState();
}

class _MyCameraAppsixState extends State<MyCameraAppsixPage> {

  String result="";
  List<CameraDescription>? cameras; //list out the camera available
  CameraController? controller; //controller for camera
  XFile? image; //for captured image

  @override
  void initState() {
    loadCamera();
    super.initState();
  }

  loadCamera() async {
    cameras = await availableCameras();
    if(cameras != null){
      controller = CameraController(cameras![0], ResolutionPreset.max);
      //cameras[0] = first camera, change to 1 to another camera

      controller!.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    }else{
      print("NO any camera found");
    }
  }
String dname=" ";
  late bool isnt=false;
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      appBar: AppBar(
        title: Text("Capture Image from Camera"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
          child: Column(
              children:[
                Container(
                    height:435,
                    width:420,
                    child: controller == null?
                    Center(child:Text("Loading Camera...")):
                    !controller!.value.isInitialized?
                    Center(
                      child: CircularProgressIndicator(),
                    ):
                    CameraPreview(controller!)
                ),

                ElevatedButton.icon( //image capture button
                  onPressed: () async{

                    try {
                     //check if controller is initialized
                          image =
                          await controller!.takePicture(); //capture image
                          //////grt content
                          final bytes = File(image!.path).readAsBytesSync();
                          String base64Image = base64Encode(bytes);

                          final pref=await SharedPreferences.getInstance();
                          String ip= pref.getString("ip").toString();
                          String lid= pref.getString("ulid").toString();
                          String uplid= pref.getString("uplid").toString();


                          var data = await http.post(Uri.parse("http://"+ip+":3000/upload_images6"),body: {"photo":base64Image,
                            'uplid':uplid,


                          });
                          var jsondata = json.decode(data.body);
                          print(jsondata);
                          var status=jsondata["status"].toString();
                          if (status=="ok") {



                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MyCameraAppseven()),
                            );




                          }
                          else{
                            setState(() {
                              String Dname= "Failed";
                            });
                          }



                    } catch (e) {
                      print(e); //show error
                    }
                  },
                  icon: Icon(Icons.camera),
                  label: Text("Capture"),
                ),
                Card(
                  child: isnt?
                  CircularProgressIndicator():
                  Text('Predicted Results:'+dname),

                ),


                Container( //show captured image
                  padding: EdgeInsets.all(30),
                  child: image == null?
                  Text("No image captured"):
                  Text(result),
                  //display captured image
                )
              ]
          )
      ),

    );
  }
}