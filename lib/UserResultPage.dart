import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:df/main.dart';

import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import 'downloadpage.dart';


class UserResultPage extends StatefulWidget {
  @override
  _UserResultPageState createState() => _UserResultPageState();
}

class _UserResultPageState extends State<UserResultPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _screeningIdController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Screening Results',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 16.0),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        SizedBox(height: 16.0),
                        Text(
                          'To view and download your screening results, please enter your SCREENING ID:',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              TextFormField(
                                controller: _screeningIdController,
                                decoration: InputDecoration(
                                  labelText: 'Screening ID',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your Screening ID';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 16.0),
                              ElevatedButton(

                                // if (_formKey.currentState!.validate()) {



                      onPressed: () async {


                        final sh = await SharedPreferences.getInstance();
                        try{

                          String screeningid=_screeningIdController.text;
                          sh.setString("screeningid", screeningid);

                          String url = sh.getString("url").toString();
                          // String url="http://192.168.167.202:3000/";

                          var data = await http.post(
                              Uri.parse(url+"and_gen_otp"),
                              body: {'screeningid':screeningid

                              });
                          print(data);
                          var jasondata = json.decode(data.body);
                          String status=jasondata['status'].toString();

                          if(status=="ok"){

                            String lid = jasondata['lid'].toString();
                            String otp = jasondata['otp'].toString();
                            sh.setString("lid", lid);
                            sh.setString("otp", otp);

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => OTPPage()),
                            );





                          }
                          else{
                            Fluttertoast.showToast(
                                msg: "No screening id",
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








                      },
                      child: Text('Get Results'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16.0,),
                IconButton(
                  icon: Icon(Icons.arrow_back_ios_new_rounded),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );// Edit profile functionality here
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OTPPage extends StatefulWidget {
  @override
  _OTPPageState createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  TextEditingController _otpController = TextEditingController();




  Future<void> _submitForm() async {
    final pref = await SharedPreferences.getInstance();
    String otps = _otpController.text;
    String totp=pref.getString("otp").toString();
    String Dname='Result';

    if (otps==totp) {
      // OTP is valid
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('OTP is valid!'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () async {


                  final sh = await SharedPreferences.getInstance();
                  try{


                    String url = sh.getString("url").toString();
                    // String url="http://192.168.167.202:3000/";

                    var data = await http.post(
                        Uri.parse(url+"get_result_user"),
                        body: {'screeningid':sh.getString("screeningid").toString()

                        });
                    print(data);
                    var jasondata = json.decode(data.body);
                    String status=jasondata['status'].toString();

                    if(status=="ok"){

                      String pth= url+ jasondata['res'];

                      sh.setString("path", pth);

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DownlodPage()),
                      );




                      // setState(() {
                      //   Dname = "Result :" + jasondata['result'].toString();
                      //   print("set");
                      // });





                    }
                    else{
                      Fluttertoast.showToast(
                          msg: "No screening id",
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






                },
              ),
            ],
          );
        },
      );
    } else {
      // OTP is invalid
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Invalid OTP'),
            content: Text('Please try again with a valid OTP.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserResultPage()),
                  );
                },
              ),
            ],
          );
        },
      );
    }
  }









  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Enter the OTP sent to your email:',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 16.0),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _otpController,
                          keyboardType: TextInputType.number,
                          maxLength: 4,
                          decoration: InputDecoration(
                            labelText: 'OTP',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter the OTP';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: _submitForm,
                          child: Text('Submit'),
                        ),
                        SizedBox(height: 16.0),
                        TextButton(
                          onPressed: () {
                            // Resend OTP logic
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Resend OTP'),
                                  content: Text('Resend OTP logic goes here.'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('OK'),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => UserResultPage()),
                                        );
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Text('Not received? Resend OTP'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
