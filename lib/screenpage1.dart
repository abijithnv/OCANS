import 'dart:io';
import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:df/screenpage2.dart';

class ScreenPage1 extends StatefulWidget {
  const ScreenPage1({super.key});

  @override
  _ScreenPage1State createState() => _ScreenPage1State();
}

class _ScreenPage1State extends State<ScreenPage1> {
  // ignore: prefer_typing_uninitialized_variables
  var _selectedSex;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _sexController = TextEditingController();
  final _mobileController = TextEditingController();
  final _lsgdController = TextEditingController();
  final _districtController = TextEditingController();
  final _occupationController = TextEditingController();

  final _aadharController = TextEditingController();
  final _dateTimeController = TextEditingController();
  File? _image;

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _sexController.dispose();
    _mobileController.dispose();
    _lsgdController.dispose();
    _districtController.dispose();
    _occupationController.dispose();

    _aadharController.dispose();
    _dateTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enroll for Oral Screening:',style: TextStyle(fontSize:25,fontFamily: 'Time New Roman'),),
      ),
      body: Container(
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
                    Text("Basic Details",
                      style: TextStyle(
                          fontSize: 20, fontFamily: 'Times New Roman'),
                    ),

                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _ageController,
                            decoration: InputDecoration(
                              labelText: 'Age',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your age';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(width: 55),
                        Text("Sex: "),
                        SizedBox(width: 5),
                        // Add some spacing between the TextFormField and DropdownButton
                        Expanded(
                          child: DropdownButton<String>(

                            value: _selectedSex,
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  _selectedSex = newValue;
                                });
                              }
                            },
                            items: <String>['Male', 'Female', 'Other']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),

                    TextFormField(
                      controller: _mobileController,
                      decoration: InputDecoration(
                        labelText: 'Mobile',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your mobile number';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _lsgdController,
                      decoration: InputDecoration(
                        labelText: 'LSGD',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your LSGD';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _districtController,
                      decoration: InputDecoration(
                        labelText: 'District',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your district';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _occupationController,
                      decoration: InputDecoration(
                        labelText: 'Occupation',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your occupation';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 16.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Photo (Optional)'),
                        SizedBox(height: 8.0),
                        Center(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: ElevatedButton(
                              onPressed: () {
                                _getImage();
                              },
                              child: Text('Upload Photo'),
                            ),
                          ),
                        ),
                      ],
                    ),

                    TextFormField(
                      controller: _aadharController,
                      decoration: InputDecoration(
                        labelText: 'Aadhar Number (Optional)',
                      ),
                    ),
                    TextFormField(
                      controller: _dateTimeController,
                      decoration: InputDecoration(
                        labelText: 'Date & Time of Enrollment',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the date and time of enrollment';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // TODO: Submit the form
                            _showSuccessDialog();
                          }
                        },
                        child: Text('Next'),
                      ),
                    ),

                    SizedBox(height: 16.0),
                    _image != null
                        ? Center(
                      child: Image.file(
                        _image!,
                        height: 200.0,
                      ),
                    )
                        : Container(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Warning'),
          content: Text('Do you wish to continue?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ScreenPage2()),
                );
              },
              child: Text('Proceed'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _getImage() async {
    //final picker = ImagePicker();
    //final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    //setState(() {
      //if (pickedFile != null) {
        //_image = File(pickedFile.path);
      //} else {
        //print('No image selected.');
      //}
    //});
  }
}

// void main() {
//   runApp(ScreenPage1());
// }