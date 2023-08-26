import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:df/predict_based_photo2.dart';

void main() {
  runApp(const ImageUpload());
}

class ImageUpload extends StatefulWidget{
  const ImageUpload({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ImageUpload();
  }
}

class _ImageUpload extends State<ImageUpload>{
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
      String lid= pref.getString("ulid").toString();



      SharedPreferences prefs = await SharedPreferences.getInstance();
      String smokingStatus=prefs.getString('smokingStatus').toString();
      String smokingProduct=prefs.getString('smokingProduct').toString();
      String smokingFrequency=prefs.getString('smokingFrequency').toString();
      String smokingDuration=prefs.getString('smokingDuration').toString();
      String smokelessTobaccoStatus=prefs.getString('smokelessTobaccoStatus').toString();
      String smokelessTobaccoProduct=prefs.getString('smokelessTobaccoProduct').toString();
      String smokelessTobaccoFrequency=prefs.getString('smokelessTobaccoFrequency').toString();
      String smokelessTobaccoDuration=prefs.getString('smokelessTobaccoDuration').toString();
      String alcoholUseStatus=prefs.getString('alcoholUseStatus').toString();
      String alcoholProduct=prefs.getString('alcoholProduct').toString();
      String alcoholUseFrequency=prefs.getString('alcoholUseFrequency').toString();
      // prefs.setString('alcoholUseFrequency', alcoholUseFrequency.toString());
      String alcoholUseDuration=prefs.getString('alcoholUseDuration').toString();
      String presenceOfSharpTeeth=prefs.getString('presenceOfSharpTeeth').toString();



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
          MaterialPageRoute(builder: (context) => ImageUploadtwo()),
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
        title: Text("Upload Image 1"),
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