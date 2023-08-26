import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:df/predict_based_photo7.dart';

void main() {
  runApp(const ImageUploadSix());
}

class ImageUploadSix extends StatefulWidget{
  const ImageUploadSix({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ImageUploadSix();
  }
}

class _ImageUploadSix extends State<ImageUploadSix>{
   String Dname='Please click upload image to get result';

  File? uploadimage;

  String get id => '';
  String get img=> '';//variable for choose file

  Future<void> chooseImage() async {
    final choosedimage = await ImagePicker().pickImage(source: ImageSource.gallery);
    //set source: ImageSource.camera to get image from camera
    setState(() {
      uploadimage = File(choosedimage!.path);
    });
  }


  Future<void> uploadImage() async {

    try{
      List<int> imageBytes = uploadimage!.readAsBytesSync();
      String baseimage = base64Encode(imageBytes);



      final bytes = File(uploadimage!.path).readAsBytesSync();
      String base64Image =  base64Encode(bytes);
      print("img_pan : $base64Image");

      final pref=await SharedPreferences.getInstance();
      String ip= pref.getString("ip").toString();
      String uplid= pref.getString("uplid").toString();

      var data = await http.post(Uri.parse("http://"+ip+":3000/upload_images6"),body: {"photo":base64Image,'uplid':uplid});
      var jsondata = json.decode(data.body);
      print(jsondata);
      var status=jsondata["status"].toString();
      if (status=="ok") {

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ImageUploadSeven()),
        );
      }
      else{
        setState(() {
          Dname= "Failed";
        });
      }


    }catch(e){
      print("Error ------------------- "+e.toString());
      //there is error during converting file image to base64 encoding.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Image 6"),
        backgroundColor: Colors.blue,
      ),
      body:Container(
        height:300,
        alignment: Alignment.center,
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center, //content alignment to center
          children: <Widget>[
            Container(  //show image here after choosing image
                child:uploadimage == null?
                Container(): //if upload image is null then show empty container
                Container(   //else show image here
                    child: SizedBox(
                        height:150,
                        child:Image.file(uploadimage!,height: 100,width: 100,) //load image from file
                    )
                )
            ),

            Container(
              //show upload button after choosing image
                child:uploadimage == null?
                Container(): //if upload image is null then show empty container
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                      Container(   //else show upload button
                      child:ElevatedButton.icon(
                      onPressed: ()  {
                      uploadImage();
                      // Navigator.push((context),MaterialPageRoute(builder: (context)=>image()));
                      //start uploading image
                      },
                      icon: Icon(Icons.file_upload),
                      label: Text("UPLOAD IMAGE"),

                      //set brightness to dark, because deepOrangeAccent is darker color
                      //so that its text color is light
                      ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Card(
                        child: Center(
                          child:Text(Dname) ,
                        ),
                      ),
                    )


                  ],
                ),
            ),


            Container(
              child: ElevatedButton.icon(
                onPressed: (){
                  chooseImage(); // call choose image function
                },
                icon:Icon(Icons.folder_open),
                label: Text("CHOOSE IMAGE"),

              ),
            ),
          ],),
      ),
    );
  }
}