//
// import 'dart:convert';
// import 'dart:io';
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
//
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
//
//
//
// void main() {
//   runApp(MyCameraPage());
// }
//
// class MyCameraPage extends StatefulWidget{
//   @override
//   _MyCameraPageState createState() => _MyCameraPageState();
// }
//
// class _MyCameraPageState extends State<MyCameraPage> {
//
//   String result="";
//   List<CameraDescription>? cameras; //list out the camera available
//   CameraController? controller; //controller for camera
//   //XFile? image; //for captured image
//
//
//   @override
//   void initState() {
//     loadCamera();
//     super.initState();
//   }
//
//   loadCamera() async {
//     cameras = await availableCameras();
//     if(cameras != null){
//       controller = CameraController(cameras![0], ResolutionPreset.max);
//       //cameras[0] = first camera, change to 1 to another camera
//
//       controller!.initialize().then((_) {
//         if (!mounted) {
//           return;
//         }
//         setState(() {});
//       });
//     }else{
//       print("No camera found");
//     }
//   }
//   String dname=" ";
//   late bool isnt=false;
//   @override
//   Widget build(BuildContext context) {
//
//     return  Scaffold(
//       appBar: AppBar(
//         title: Text("Upload Images"),
//         backgroundColor: Colors.blue,
//       ),
//       body: Container(
//           child: Column(
//               children:[
//                 Container(
//                     height:435,
//                     width:420,
//                     child: controller == null?
//                     Center(child:Text("Loading Camera...")):
//                     !controller!.value.isInitialized?
//                     Center(
//                       child: CircularProgressIndicator(),
//                     ):
//                     CameraPreview(controller!)
//                 ),
//
//                 ElevatedButton.icon( //image capture button
//                   onPressed: () async{
//                     setState(() {
//                       isnt=true;
//                     });
//                     try {
//                       if(controller != null) { //check if contrller is not null
//                         if (controller!.value
//                             .isInitialized) { //check if controller is initialized
//                           //image =
//                           //await controller!.takePicture(); //capture image
//                           //////grt content
//                           //final bytes = File(image!.path).readAsBytesSync();
//                           //String base64Image = base64Encode(bytes);
//                           //print("img_pan : $base64Image");
//                           //final pref = await SharedPreferences.getInstance();
//                           String ip = "192.168.29.54";
//                           // String ip = pref.getString("ip").toString();
//                           //String lid = pref.getString("lid").toString();
//
//
//                           var data = await http.post(
//                               Uri.parse(
//                                   "http://" + ip + ":5000/Photo_request"));
//                               //body: {"photo": base64Image});
//                           var jsondata = json.decode(data.body);
//                           print(jsondata);
//                           var status = jsondata["status"].toString();
//                           if (status == "ok") {
//
//                             setState(() {
//                               isnt=false;
//                               dname =
//                                   "" + jsondata['result'].toString();
//                               print("set");
//                             });
//                           }
//                           else {
//                             setState(() {
//                               dname = "Uploaded photo error, try another photo";
//                               isnt=false;
//                             });
//                           }
//                           setState(() {
//                             //update UI
//                           });
//                         }
//                       }
//                     } catch (e) {
//                       print(e); //show error
//                     }
//                   },
//                   icon: Icon(Icons.camera),
//                   label: Text("Capture"),
//                 ),
//                 Card(
//                   child: isnt?
//                   CircularProgressIndicator():
//                   Text('Predicted Results:'+dname),
//
//                 ),
//
//
//                 Container( //show captured image
//                   padding: EdgeInsets.all(30),
//                   child: (//image == null?
//                   Text("No image captured")
//                   //Text(result),
//                   //display captured image
//                 )
//       )
//               ]
//           )
//       ),
//
//     );
//   }
// }