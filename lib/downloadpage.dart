import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart'as http;
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:df/u_home.dart';
import 'package:df/v_home.dart';
import 'package:dio/dio.dart';
import 'package:open_file/open_file.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';
void main() {
  runApp(const DownlodPage());
}

class DownlodPage extends StatelessWidget {
  const DownlodPage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Job seeker',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const DownlodPagePage(title: 'Download File'),
    );
  }
}

class DownlodPagePage extends StatefulWidget {
  const DownlodPagePage({super.key, required this.title});


  final String title;

  @override
  State<DownlodPagePage> createState() => _DownlodPageState();
}

class _DownlodPageState extends State<DownlodPagePage> {
  final _formKey = GlobalKey<FormState>();
  // TextEditingController _feedback = new TextEditingController();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(

          title: Text(widget.title),
        ),
        body:SingleChildScrollView (
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 120,
                    // child: TextFormField(
                    //   controller: _feedback,
                    //   keyboardType: TextInputType.multiline,
                    //   textAlignVertical: TextAlignVertical.bottom,
                    //   maxLength: null,
                    //   minLines: null,
                    //   decoration: InputDecoration(
                    //       contentPadding: EdgeInsets.only(top: 80,bottom: 12
                    //
                    //       ),
                    //       labelText: 'Feedback',
                    //       prefixIcon: Icon(Icons.abc_outlined),
                    //       floatingLabelBehavior: FloatingLabelBehavior.auto,
                    //       border: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(25)
                    //       )
                    //   ),
                    //   validator: (v){
                    //     if(v!.isEmpty){
                    //       return 'Must enter valid details';
                    //     }
                    //     return null;
                    //   },
                    // ),
                  ),
                  SizedBox(height: 12,),
                  SizedBox(width: 350,height: 50,
                    child: ElevatedButton(onPressed: (){
                      if (_formKey.currentState!.validate()) {
                        send_feedback();
                        // sen();

                      }
                      else{
                        Fluttertoast.showToast(
                            msg: "Form is not completed",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.grey,
                            textColor: Colors.white,
                            fontSize: 12.0
                        );
                      }
                    },

                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)
                            )
                        ),
                        child: Text('Download Report')),
                  ),
                  // PDFView(
                  //   filePath: "https://www.africau.edu/images/default/sample.pdf",
                  // )


                ],
              ),
            ),
          ),
        )
    );
  }

  void downloadFile() async {

    print("inside");
    final url = 'https://www.africau.edu/images/default/sample.pdf'; // Replace with the URL of the file you want to download
    final fileName = 'file.pdf'; // Replace with the desired file name

    final directory = await getExternalStorageDirectory();
    final savePath = '${directory!.path}/$fileName';

    await FlutterDownloader.enqueue(
      url: url,
      savedDir: directory.path,
      fileName: fileName,
      showNotification: true,
      openFileFromNotification: true,
    );
  }


  Future<void>send_feedback()async{
    final sh = await SharedPreferences.getInstance();
    try{
      String url = sh.getString("url").toString();
      String lid = sh.getString("path").toString();
      // String feedback = _feedback.text.toString();

      String urla = 'https://example.com/path/to/your/file.pdf'; // Replace with your PDF file URL



      final url1 = lid; // Replace with your PDF file URL

      if (await canLaunch(url1)) {
        await launch(url1);

        print("ok");
      } else {
        print("no");
        throw 'Could not launch $url1';
      }



    }catch(e){
      Fluttertoast.showToast(
          msg: "eeeee"+e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.orangeAccent,
          textColor: Colors.white,
          fontSize: 12.0
      );
      print("Error--------------"+e.toString());
    }


  }
}