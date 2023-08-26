import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'Login.dart';

//
// void main() {
//   runApp(const UserRegistration());
// }

class VolunteerSignup extends StatelessWidget {
  const VolunteerSignup({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const VolunteerSignupPage(title: "Volunteer Signup",),
    );
  }
}

class VolunteerSignupPage extends StatefulWidget {
  const VolunteerSignupPage({super.key, required this.title});


  final String title;

  @override
  State<VolunteerSignupPage> createState() => _VolunteerSignupPageState();
}

class _VolunteerSignupPageState extends State<VolunteerSignupPage> {
  File?uploadimage;
  Future<void> chooseImage() async {
    final choosedimage = await ImagePicker().pickImage(source: ImageSource.gallery);
    //set source: ImageSource.camera to get image from camera
    setState(() {
      uploadimage = File(choosedimage!.path);
    });
  }

  final _formKey = GlobalKey<FormState>();
  String selectedGender='Male';
  TextEditingController dateController = new TextEditingController();
  TextEditingController name = new TextEditingController();
  TextEditingController place = new TextEditingController();
  TextEditingController post = new TextEditingController();
  TextEditingController pin = new TextEditingController();
  TextEditingController district = new TextEditingController();
  TextEditingController state = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  final DateFormat _dateFormatter = DateFormat('yyyy-MM-dd');

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        dateController.text = _dateFormatter.format(picked);
      });
    }
  }



  @override
  Widget build(BuildContext context) {

    return  WillPopScope(
        onWillPop: () async {
          final shouldPop = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Are you Sure You To Exit?'),
                actionsAlignment: MainAxisAlignment.spaceBetween,
                actions: [
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          // Navigator.pushReplacement(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => IP(),
                          //   ),
                          // );
                          Navigator.pop(context, true);

                        },
                        child: const Text('Yes'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        child: const Text('No'),
                      ),
                    ],
                  )
                ],
              );
            },
          );
          return shouldPop!;
        },
        child: Scaffold(
            appBar: AppBar(

              title: Text(widget.title),
            ),
            body:SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      uploadimage==null?
                      InkWell(
                        onTap: (){
                          chooseImage();
                        },
                        child: CircleAvatar(
                          child: Icon(Icons.person),
                          radius: 50,
                        ),
                      ):
                      InkWell(
                        onTap: (){
                          chooseImage();
                        },
                        child: CircleAvatar(
                          backgroundImage: FileImage(uploadimage!),
                          radius: 70,
                        ),
                      ),
                      SizedBox(height: 12,),


                      TextFormField(
                        controller: name,
                        decoration: InputDecoration(
                            labelText: 'Full Name',
                            prefixIcon: Icon(Icons.abc_outlined),
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25)
                            )
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                        ],
                        validator: (v){
                          if(v!.isEmpty){
                            return 'Must enter valid name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 12,),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey, // Border color when not focused
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child:Row(
                          children: [
                            Expanded(
                              child: RadioListTile(
                                title: Text('Male'),
                                value: 'Male',
                                groupValue: selectedGender,
                                onChanged: (value) {
                                  setState(() {
                                    selectedGender = value!;
                                  });
                                },
                                // controlAffinity: ListTileControlAffinity.leading,
                                contentPadding: EdgeInsets.all(0.0),
                              ),
                            ),
                            Expanded(
                              child: RadioListTile(
                                title: Text('Female'),
                                value: 'Female',
                                groupValue: selectedGender,
                                onChanged: (value) {
                                  setState(() {
                                    selectedGender = value!;
                                  });
                                },
                                // controlAffinity: ListTileControlAffinity.leading,
                                contentPadding: EdgeInsets.all(0.0),
                              ),
                            ),
                            Expanded(
                              child: RadioListTile(
                                title: Text('Other'),
                                value: 'Other',
                                groupValue: selectedGender,
                                onChanged: (value) {
                                  setState(() {
                                    selectedGender = value!;
                                  });
                                },
                                // controlAffinity: ListTileControlAffinity.leading,
                                contentPadding: EdgeInsets.all(0.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12,),

                      TextFormField(
                        controller: dateController,
                        readOnly: true,
                        onTap: () {
                          _selectDate(context);
                        },
                        decoration: InputDecoration(
                            labelText: 'Date of Birth',
                            prefixIcon: Icon(Icons.date_range_outlined),
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25)
                            )
                        ),
                        validator: (v){
                          if(v!.isEmpty){
                            return 'Must enter valid DOB';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 12,),




                      TextFormField(
                        controller: phone,
                        inputFormatters: [LengthLimitingTextInputFormatter(10)],
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            labelText: 'Phone',
                            prefixIcon: Icon(Icons.phone),
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25)
                            )
                        ),
                        validator: (v){
                          if(v!.isEmpty){
                            return 'Must enter valid number';
                          }
                          else if(v.length < 10) {
                            return 'Phone Number must be at least 10 Digits long';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 12,),

                      TextFormField(
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email_outlined),
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25)
                            )
                        ),
                        validator: (v){
                          if(v!.isEmpty){
                            return 'Must enter valid Email';
                          }
                          bool isValidEmail = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(v);
                          if (!isValidEmail) {
                            return 'Invalid email format';
                          }
                            return null;

                        },
                      ),
                      SizedBox(height: 12,),

                      TextFormField(
                        controller: place,
                        decoration: InputDecoration(
                            labelText: 'Place',
                            prefixIcon: Icon(Icons.place_outlined),
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25)
                            )
                        ),
                        validator: (v){
                          if(v!.isEmpty){
                            return 'Must enter valid place';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 12,),

                      TextFormField(
                        controller: post,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25)
                          ),

                          labelText: 'Post',
                          prefixIcon: Icon(Icons.post_add_outlined),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                        validator: (v){
                          if(v!.isEmpty){
                            return 'Must enter valid post';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 12,),
                      TextFormField(
                        controller: pin,
                        inputFormatters: [LengthLimitingTextInputFormatter(6)],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25)
                          ),

                          labelText: 'Pin',
                          prefixIcon: Icon(Icons.pin_outlined),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                        validator: (v){
                          if(v!.isEmpty){
                            return 'Must enter valid pin';
                          }
                          else if(v.length < 6) {
                            return 'Pin Code must be at least 6 characters long';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 12,),
                      TextFormField(
                        controller: district,
                        decoration: InputDecoration(
                            labelText: 'District',
                            prefixIcon: Icon(Icons.map_outlined),
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25)
                            )
                        ),
                        validator: (v){
                          if(v!.isEmpty){
                            return 'Must enter District';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 12,),

                      TextFormField(
                        controller: state,
                        decoration: InputDecoration(

                            labelText: 'State',
                            prefixIcon: Icon(Icons.local_activity_outlined),
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25)
                            )
                        ),
                        validator: (v){
                          if(v!.isEmpty){
                            return 'Must enter valid state ';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 12,),

                      TextFormField(
                        controller: password,
                        inputFormatters: [LengthLimitingTextInputFormatter(6)],
                        decoration: InputDecoration(

                            labelText: 'Password',
                            prefixIcon: Icon(Icons.password),

                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25)
                            )
                        ),
                        validator: (v){
                          if(v!.isEmpty) {
                              return 'Must enter valid Password ';
                            }
                            else if(v.length < 6) {
                              return 'Password must be at least 6 characters long';
                            }

                          return null;
                        },
                      ),
                      SizedBox(height: 12,),


                      SizedBox(width: 350,height: 50,
                        child: ElevatedButton(onPressed: (){
                          if (_formKey.currentState!.validate()) {
                            if(uploadimage==null){
                              Fluttertoast.showToast(
                                  msg: "Upload photo",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.grey,
                                  textColor: Colors.white,
                                  fontSize: 12.0
                              );

                            }else {
                              SignupUser();
                            }

                          }else{
                            Fluttertoast.showToast(
                                msg: "Fill all the fields",
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
                            child: Text('Register')),
                      )


                    ],
                  ),
                ),
              ),
            )
        )
    );
  }



  Future<void>SignupUser()async{
    final ips = await SharedPreferences.getInstance();
    try{
      String url = ips.getString("url").toString();

      String nm = name.text.toString();
      String dob = dateController.text.toString();
      String gender = selectedGender.toString();
      String phn = phone.text.toString();
      String eml = email.text.toString();
      String plc = place.text.toString();
      String pst = post.text.toString();
      String pn = pin.text.toString();
      String dist = district.text.toString();
      String stt = state.text.toString();
      String passw = password.text.toString();
      final bytes = File(uploadimage!.path).readAsBytesSync();
      String base64Image =  base64Encode(bytes);
      print("img_pan : $base64Image");


      var data = await http.post(
          Uri.parse(url+"and_vsignup"),
          body: {
            'nm':nm,
            "phn":phn,
            "dob":dob,
            "eml":eml,
            "plc":plc,
            "pst":pst,
            "pn":pn,
            "gender":gender,
            "dist":dist,
            "stt":stt,
            "password":passw,
            "photo":base64Image
          });
      print(data);
      var jasondata = json.decode(data.body);
      String status=jasondata['status'].toString();

      if(status=="ok"){

        Fluttertoast.showToast(
            msg: "Registration success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 12.0
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );


      }
      else{
        Fluttertoast.showToast(
            msg: "Registration error",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 12.0
        );

      }
    }catch(e){
      Fluttertoast.showToast(
          msg: "eeeee-connection"+e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 12.0
      );
      print("Error--------------"+e.toString());
    }


  }
}
