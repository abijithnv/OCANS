import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:df/predict_based_photo.dart';

import '../Login.dart';
import 'cam flut.dart';
import 'expert_home.dart';
//
// void main() {
//   runApp(const JobSregistration());
// }

class VolSurveynew extends StatelessWidget {
  const VolSurveynew({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const VolSurveynewPage(title: 'Update Profile'),
    );
  }
}

class VolSurveynewPage extends StatefulWidget {
  const VolSurveynewPage({super.key, required this.title});


  final String title;

  @override
  State<VolSurveynewPage> createState() => _VolSurveynewPageState();
}

class _VolSurveynewPageState extends State<VolSurveynewPage> {
  final _formKey = GlobalKey<FormState>();

  String selectedGender='Male';
  File? uploadimage;
  String src="";
  String paths="no";
  TextEditingController name = new TextEditingController();
  TextEditingController dateController = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController place = new TextEditingController();
  TextEditingController post = new TextEditingController();
  TextEditingController pin = new TextEditingController();
  TextEditingController district = new TextEditingController();
  TextEditingController state = new TextEditingController();
  TextEditingController experience = new TextEditingController();
  TextEditingController mci = new TextEditingController();
  TextEditingController designation = new TextEditingController();
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
  Future<void> chooseImage() async {
    final choosedimage = await ImagePicker().pickImage(source: ImageSource.gallery);
    //set source: ImageSource.camera to get image from camera
    setState(() {
      uploadimage = File(choosedimage!.path);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    

  }
  String? smokingStatus;
  String? smokingProduct;
  String? smokingFrequency;
  String? smokingDuration;
  String? smokelessTobaccoStatus;
  String? smokelessTobaccoProduct;
  String? smokelessTobaccoFrequency;
  String? smokelessTobaccoDuration;
  String? alcoholUseStatus;
  String? alcoholProduct;
  String? alcoholUseFrequency;
  String? alcoholUseDuration;
  String? presenceOfSharpTeeth;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(

          title: Text(widget.title),
        ),
        body:Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blue,
                Colors.purple,
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text("Specific Details",
                        style: TextStyle(
                            fontSize: 20, fontFamily: 'Times New Roman'),
                      ),


                      SizedBox(height: 16.0),
                      DropdownButtonFormField<String>(
                        value: smokingStatus,
                        onChanged: (value) {
                          setState(() {
                            smokingStatus = value;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Smoking status',
                        ),
                        items: [
                          DropdownMenuItem(
                            value: 'Current user',
                            child: Text('Current user'),
                          ),
                          DropdownMenuItem(
                            value: 'Ex-user',
                            child: Text('Ex-user'),
                          ),
                          DropdownMenuItem(value: 'non-user',
                              child: Text('non-user'))
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Select Smoking status';
                          }
                          return null;
                        },
                        onSaved: (value) => smokingStatus = value,
                      ),


                      SizedBox(height: 16.0),
                      DropdownButtonFormField<String>(
                        value: smokingProduct,
                        onChanged: (value) {
                          setState(() {
                            smokingProduct = value;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Smoking product',
                        ),
                        items: [
                          DropdownMenuItem(
                            value: 'beedi',
                            child: Text('beedi'),
                          ),
                          DropdownMenuItem(
                            value: 'cigarette',
                            child: Text('cigarette'),
                          ),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select Smoking product';
                          }
                          return null;
                        },
                        onSaved: (value) => smokingProduct = value,
                      ),


                      SizedBox(height: 16.0),
                      DropdownButtonFormField<String>(
                        value: smokingFrequency,
                        onChanged: (value) {
                          setState(() {
                            smokingFrequency = value;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Smoking frequency',
                        ),
                        items: [
                          DropdownMenuItem(
                            value: 'Present',
                            child: Text('Present'),
                          ),
                          DropdownMenuItem(
                            value: 'occupational',
                            child: Text('occupational'),
                          ),
                          DropdownMenuItem(
                            value: 'chronic',
                            child: Text('chronic'),
                          ),
                          DropdownMenuItem(
                            value: 'Ex',
                            child: Text('Ex'),
                          ),
                          DropdownMenuItem(
                            value: 'Unknown',
                            child: Text('Unknown'),
                          ),
                          DropdownMenuItem(
                            value: 'NA',
                            child: Text('NA'),
                          ),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select smoking frequency';
                          }
                          return null;
                        },
                        onSaved: (value) => smokingFrequency = value,
                      ),


                      SizedBox(height: 16.0),
                      DropdownButtonFormField<String>(
                        value: smokingDuration,
                        onChanged: (value) {
                          setState(() {
                            smokingDuration = value;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Smoking Duration',
                        ),
                        items: [
                          DropdownMenuItem(
                            value: 'Long term',
                            child: Text('Long term'),
                          ),
                          DropdownMenuItem(
                            value: 'Short term',
                            child: Text('Short term'),
                          ),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select smoking duration';
                          }
                          return null;
                        },
                        onSaved: (value) => smokingDuration = value,
                      ),



                      SizedBox(height: 50.0),
                      DropdownButtonFormField<String>(
                        value: smokelessTobaccoStatus,
                        onChanged: (value) {
                          setState(() {
                            smokelessTobaccoStatus = value;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Smokeless tobacco status',
                        ),
                        items: [
                          DropdownMenuItem(
                            value: 'current',
                            child: Text('current'),
                          ),
                          DropdownMenuItem(
                            value: 'ex-user',
                            child: Text('ex-user'),
                          ),
                          DropdownMenuItem(
                            value: 'non-user',
                            child: Text('non-user'),
                          ),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select smokeless tobacco status';
                          }
                          return null;
                        },
                        onSaved: (value) => smokelessTobaccoStatus = value,
                      ),


                      SizedBox(height: 16.0),
                      DropdownButtonFormField<String>(
                        value: smokelessTobaccoProduct,
                        onChanged: (value) {
                          setState(() {
                            smokelessTobaccoProduct = value;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Smokeless tobacco product',
                        ),
                        items: [
                          DropdownMenuItem(
                            value: 'Betel quid',
                            child: Text('Betel quid'),
                          ),
                          DropdownMenuItem(
                            value: 'pan parag',
                            child: Text('pan parag'),
                          ),
                          DropdownMenuItem(
                            value: 'Hans',
                            child: Text('Hans'),
                          ),
                          DropdownMenuItem(
                            value: 'Madhu',
                            child: Text('Madhu'),
                          ),
                          DropdownMenuItem(
                            value: 'cool lip',
                            child: Text('cool lip'),
                          ),
                          DropdownMenuItem(
                            value: 'areca nut alone',
                            child: Text('areca nut alone'),
                          ),
                          DropdownMenuItem(
                            value: 'other',
                            child: Text('other'),
                          ),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select smokeless tobacco product';
                          }
                          return null;
                        },
                        onSaved: (value) => smokelessTobaccoProduct = value,
                      ),


                      SizedBox(height: 16.0),
                      DropdownButtonFormField<String>(
                        value: smokelessTobaccoFrequency,
                        onChanged: (value) {
                          setState(() {
                            smokelessTobaccoFrequency = value;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Smokeless tobacco frequency',
                        ),
                        items: [
                          DropdownMenuItem(
                            value: 'Present',
                            child: Text('Present'),
                          ),
                          DropdownMenuItem(
                            value: 'occupational',
                            child: Text('occupational'),
                          ),
                          DropdownMenuItem(
                            value: 'chronic',
                            child: Text('chronic'),
                          ),
                          DropdownMenuItem(
                            value: 'Ex',
                            child: Text('Ex'),
                          ),
                          DropdownMenuItem(
                            value: 'Unknown',
                            child: Text('Unknown'),
                          ),
                          DropdownMenuItem(
                            value: 'NA',
                            child: Text('NA'),
                          ),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select smokeless tobacco frequency';
                          }
                          return null;
                        },
                        onSaved: (value) => smokelessTobaccoFrequency = value,
                      ),


                      SizedBox(height: 16.0),
                      DropdownButtonFormField<String>(
                        value: smokelessTobaccoDuration,
                        onChanged: (value) {
                          setState(() {
                            smokelessTobaccoDuration = value;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Smokeless tobacco Duration',
                        ),
                        items: [
                          DropdownMenuItem(
                            value: 'Long term',
                            child: Text('Long term'),
                          ),
                          DropdownMenuItem(
                            value: 'Short term',
                            child: Text('Short term'),
                          ),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select smokeless tobacco duration';
                          }
                          return null;
                        },
                        onSaved: (value) => smokelessTobaccoDuration = value,
                      ),


                      SizedBox(height: 50.0),
                      DropdownButtonFormField<String>(
                        value: alcoholUseStatus,
                        onChanged: (value) {
                          setState(() {
                            alcoholUseStatus = value;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Alcohol use status',
                        ),
                        items: [
                          DropdownMenuItem(
                            value: 'current',
                            child: Text('current'),
                          ),
                          DropdownMenuItem(
                            value: 'ex-user',
                            child: Text('ex-user'),
                          ),
                          DropdownMenuItem(
                            value: 'non-user',
                            child: Text('non-user'),
                          ),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select Alcohol use status';
                          }
                          return null;
                        },
                        onSaved: (value) => alcoholUseStatus = value,
                      ),


                      SizedBox(height: 16.0),
                      DropdownButtonFormField<String>(
                        value: alcoholProduct,
                        onChanged: (value) {
                          setState(() {
                            alcoholProduct = value;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Alcohol Product',
                        ),
                        items: [
                          DropdownMenuItem(
                            value: 'Toddy',
                            child: Text('Toddy'),
                          ),
                          DropdownMenuItem(
                            value: 'country liqour',
                            child: Text('country liqour'),
                          ),
                          DropdownMenuItem(
                            value: 'Foreign liqour',
                            child: Text('Foreign liqour'),
                          ),
                          DropdownMenuItem(
                            value: 'others',
                            child: Text('others'),
                          ),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select alcohol product';
                          }
                          return null;
                        },
                        onSaved: (value) => alcoholProduct = value,
                      ),


                      SizedBox(height: 16.0),
                      DropdownButtonFormField<String>(
                        value: alcoholUseFrequency,
                        onChanged: (value) {
                          setState(() {
                            alcoholUseFrequency = value;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Alcohol use frequency',
                        ),
                        items: [
                          DropdownMenuItem(
                            value: 'Present',
                            child: Text('Present'),
                          ),
                          DropdownMenuItem(
                            value: 'occupational',
                            child: Text('occupational'),
                          ),
                          DropdownMenuItem(
                            value: 'chronic',
                            child: Text('chronic'),
                          ),
                          DropdownMenuItem(
                            value: 'Ex',
                            child: Text('Ex'),
                          ),
                          DropdownMenuItem(
                            value: 'Unknown',
                            child: Text('Unknown'),
                          ),
                          DropdownMenuItem(
                            value: 'NA',
                            child: Text('NA'),
                          ),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select alcohol frequency';
                          }
                          return null;
                        },
                        onSaved: (value) => alcoholUseFrequency = value,
                      ),


                      SizedBox(height: 16.0),
                      DropdownButtonFormField<String>(
                        value: alcoholUseDuration,
                        onChanged: (value) {
                          setState(() {
                            alcoholUseDuration = value;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Alcohol use duration',
                        ),
                        items: [
                          DropdownMenuItem(
                            value: 'Long term',
                            child: Text('Long term'),
                          ),
                          DropdownMenuItem(
                            value: 'Short term',
                            child: Text('Short term'),
                          ),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select Alcohol use duration';
                          }
                          return null;
                        },
                        onSaved: (value) => alcoholUseDuration = value,
                      ),


                      SizedBox(height: 50.0),
                      DropdownButtonFormField<String>(
                        value: presenceOfSharpTeeth,
                        onChanged: (value) {
                          setState(() {
                            presenceOfSharpTeeth = value;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Presence of Sharp Teeth',
                        ),
                        items: [
                          DropdownMenuItem(
                            value: 'Yes',
                            child: Text('Yes'),
                          ),
                          DropdownMenuItem(
                            value: 'No',
                            child: Text('No'),
                          ),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select the presence of sharp teeth';
                          }
                          return null;
                        },
                        onSaved: (value) => presenceOfSharpTeeth = value,
                      ),

                      SizedBox(height: 16.0),
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {

                              print("Hello100");


                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              prefs.setString('smokingStatus', smokingStatus.toString());
                              prefs.setString('smokingProduct', smokingProduct.toString());
                              prefs.setString('smokingFrequency', smokingFrequency.toString());
                              prefs.setString('smokingDuration', smokingDuration.toString());
                              prefs.setString('smokelessTobaccoStatus', smokelessTobaccoStatus.toString());
                              prefs.setString('smokelessTobaccoProduct', smokelessTobaccoProduct.toString());
                              prefs.setString('smokelessTobaccoFrequency', smokelessTobaccoFrequency.toString());
                              prefs.setString('smokelessTobaccoDuration', smokelessTobaccoDuration.toString());
                              prefs.setString('alcoholUseStatus', alcoholUseStatus.toString());
                              prefs.setString('alcoholProduct', alcoholProduct.toString());
                              prefs.setString('alcoholUseFrequency', alcoholUseFrequency.toString());
                              // prefs.setString('alcoholUseFrequency', alcoholUseFrequency.toString());
                              prefs.setString('alcoholUseDuration', alcoholUseDuration.toString());
                              prefs.setString('presenceOfSharpTeeth', presenceOfSharpTeeth.toString());

                              // MaterialPageRoute(builder: (context) => ImageUpload());

                              // Navigator.push(context, N)

                              print("Hello2");

                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => MyCameraApp()),
                              );
                              

                              // String smokingStatus;
                              // String? smokingProduct;
                              // String? smokingFrequency;
                              // String? smokingDuration;
                              // String? smokelessTobaccoStatus;
                              // String? smokelessTobaccoProduct;
                              // String? smokelessTobaccoFrequency;
                              // String? smokelessTobaccoDuration;
                              // String? alcoholUseStatus;
                              // String? alcoholProduct;
                              // String? alcoholUseFrequency;
                              // String? alcoholUseDuration;
                              // String? presenceOfSharpTeeth;
                              
                            
                          },
                          child: Text('Next'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
    );
  }



 

}

void main() {
  runApp(VolSurveynew());
}
