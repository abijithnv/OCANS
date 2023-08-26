import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:df/u_home.dart';
import 'package:df/v_home.dart';

void main() {
  runApp(const SendFeedback());
}

class SendFeedback extends StatelessWidget {
  const SendFeedback({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Job seeker',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const SendFeedbackPage(title: 'Notification'),
    );
  }
}

class SendFeedbackPage extends StatefulWidget {
  const SendFeedbackPage({super.key, required this.title});


  final String title;

  @override
  State<SendFeedbackPage> createState() => _SendFeedbackPageState();
}

class _SendFeedbackPageState extends State<SendFeedbackPage> {
  final _formKey = GlobalKey<FormState>();
TextEditingController _feedback = new TextEditingController();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(

          title: Text(widget.title),
        ),
        body:Center (
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 120,
                    child: TextFormField(
                      controller: _feedback,
                      keyboardType: TextInputType.multiline,
                      textAlignVertical: TextAlignVertical.bottom,
                      maxLength: null,
                      minLines: null,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 80,bottom: 12

                          ),
                          labelText: 'Feedback',
                          prefixIcon: Icon(Icons.abc_outlined),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25)
                          )
                      ),
                      validator: (v){
                        if(v!.isEmpty){
                          return 'Must enter valid details';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 12,),
                  SizedBox(width: 350,height: 50,
                    child: ElevatedButton(onPressed: (){
                      if (_formKey.currentState!.validate()) {
                        send_feedback();


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
                        child: Text('Add feedback')),
                  )


                ],
              ),
            ),
          ),
        )
    );
  }

  Future<void>send_feedback()async{
    final sh = await SharedPreferences.getInstance();
    try{
      String url = sh.getString("url").toString();
      String lid = sh.getString("lid").toString();
      String feedback = _feedback.text.toString();


      var data = await http.post(
          Uri.parse(url+"user_send_feedback"),
          body: {
            'lid':lid,
            'feedback':feedback,
          });
      print(data);
      var jasondata = json.decode(data.body);
      String status=jasondata['status'].toString();

      if(status=="ok"){

        // if(utype=='Job_seeker'){
        Fluttertoast.showToast(
            msg: "Feedback send",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 12.0
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  VolunteerHomePage()),
        );
      }
      else{
        Fluttertoast.showToast(
            msg: "Error",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.orangeAccent,
            textColor: Colors.white,
            fontSize: 12.0
        );
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