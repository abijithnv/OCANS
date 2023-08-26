
import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:df/predict_based_photo2.dart';

import 'cam flut2.dart';
Future<void> main() async {
  runApp(MyCameraApp());
}

class MyCameraApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      home: MyCameraPage(),
    );
  }
}

class MyCameraPage extends StatefulWidget{
  @override
  _MyCameraPageState createState() => _MyCameraPageState();
}

class _MyCameraPageState extends State<MyCameraPage> {

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

                          String smokingStatus=pref.getString('smokingStatus').toString();
                          String smokingProduct=pref.getString('smokingProduct').toString();
                          String smokingFrequency=pref.getString('smokingFrequency').toString();
                          String smokingDuration=pref.getString('smokingDuration').toString();
                          String smokelessTobaccoStatus=pref.getString('smokelessTobaccoStatus').toString();
                          String smokelessTobaccoProduct=pref.getString('smokelessTobaccoProduct').toString();
                          String smokelessTobaccoFrequency=pref.getString('smokelessTobaccoFrequency').toString();
                          String smokelessTobaccoDuration=pref.getString('smokelessTobaccoDuration').toString();
                          String alcoholUseStatus=pref.getString('alcoholUseStatus').toString();
                          String alcoholProduct=pref.getString('alcoholProduct').toString();
                          String alcoholUseFrequency=pref.getString('alcoholUseFrequency').toString();
                          // pref.setString('alcoholUseFrequency', alcoholUseFrequency.toString());
                          String alcoholUseDuration=pref.getString('alcoholUseDuration').toString();
                          String presenceOfSharpTeeth=pref.getString('presenceOfSharpTeeth').toString();



                          var data = await http.post(Uri.parse("http://"+ip+":3000/upload_images"),body: {"photo":base64Image,
                            'lid':lid,
                            'smokingStatus':smokingStatus,
                            'smokingProduct':smokingProduct,
                            'smokingFrequency':smokingFrequency,
                            'smokingDuration':smokingDuration,
                            'smokelessTobaccoStatus':smokelessTobaccoStatus,
                            'smokelessTobaccoProduct':smokelessTobaccoProduct,
                            'smokelessTobaccoFrequency':smokelessTobaccoFrequency,
                            'smokelessTobaccoDuration':smokelessTobaccoDuration,
                            'alcoholUseStatus':alcoholUseStatus,
                            'alcoholProduct':alcoholProduct,
                            'alcoholUseFrequency':alcoholUseFrequency,
                            'alcoholUseDuration':alcoholUseDuration,
                            'presenceOfSharpTeeth':presenceOfSharpTeeth,

                          });
                          var jsondata = json.decode(data.body);
                          print(jsondata);
                          var status=jsondata["status"].toString();
                          if (status=="ok") {

                            String uplid = jsondata['uplid'].toString();
                            pref.setString("uplid", uplid);

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MyCameraApptwo()),
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