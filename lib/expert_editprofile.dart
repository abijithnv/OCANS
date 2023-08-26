import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Login.dart';
import 'expert_home.dart';
//
// void main() {
//   runApp(const JobSregistration());
// }

class ExpEditProfile extends StatelessWidget {
  const ExpEditProfile({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const ExpEditProfilePage(title: 'Update Profile'),
    );
  }
}

class ExpEditProfilePage extends StatefulWidget {
  const ExpEditProfilePage({super.key, required this.title});


  final String title;

  @override
  State<ExpEditProfilePage> createState() => _ExpEditProfilePageState();
}

class _ExpEditProfilePageState extends State<ExpEditProfilePage> {
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
    _getNames();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
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
                      child:CircleAvatar(
                        radius: 110,
                        backgroundImage:NetworkImage(src),
                      ),



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


                  TextFormField(
                    controller: phone,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [LengthLimitingTextInputFormatter(10)],
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
                      else if(v.length < 3) {
                        return 'Place must be at least 3 characters long';
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
                    keyboardType: TextInputType.number,
                    inputFormatters: [LengthLimitingTextInputFormatter(6)],
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
                        return 'Pin code must be at least 6 characters long';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 12,),
                  TextFormField(
                    controller:district ,
                    decoration: InputDecoration(
                        labelText: 'District',
                        prefixIcon: Icon(Icons.location_city_outlined),
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
                        prefixIcon: Icon(Icons.map_outlined),
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
                    controller: experience,
                    decoration: InputDecoration(

                        labelText: 'Qualification',
                        prefixIcon: Icon(Icons.work_history_outlined),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25)
                        )
                    ),
                    validator: (v){
                      if(v!.isEmpty){
                        return 'Must enter experience details';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 12,),


                  TextFormField(
                    controller: mci,
                    decoration: InputDecoration(

                        labelText: 'MCI',
                        prefixIcon: Icon(Icons.local_hospital_outlined),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25)
                        )
                    ),
                    validator: (v){
                      if(v!.isEmpty){
                        return 'Must enter MCI details';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 12,),


                  TextFormField(
                    controller: designation,
                    decoration: InputDecoration(

                        labelText: 'Designation',
                        prefixIcon: Icon(Icons.sensor_occupied_outlined),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25)
                        )
                    ),
                    validator: (v){
                      if(v!.isEmpty){
                        return 'Must enter designation details';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 12,),








                  SizedBox(width: 350,height: 50,
                    child: ElevatedButton(onPressed: (){
                      if (_formKey.currentState!.validate()) {
                        // if(uploadimage==null){
                        //   Fluttertoast.showToast(
                        //       msg: "Upload photo",
                        //       toastLength: Toast.LENGTH_SHORT,
                        //       gravity: ToastGravity.BOTTOM,
                        //       backgroundColor: Colors.grey,
                        //       textColor: Colors.white,
                        //       fontSize: 12.0
                        //   );
                        //
                        // }else{
                          SignupJS();
                        // }


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
                        child: Text('Update')),
                  )


                ],
              ),
            ),
          ),
        )
    );
  }



  Future<void>SignupJS()async{
    final ips = await SharedPreferences.getInstance();
    try{
      String url = ips.getString("url").toString();
      String lid = ips.getString("lid").toString();

      String nm = name.text.toString();
      String dob = dateController.text.toString();
      // String gender = selectedGender.toString();
      String phn = phone.text.toString();
      String eml = email.text.toString();
      String plc = place.text.toString();
      String pst = post.text.toString();
      String pn = pin.text.toString();
      String dist = district.text.toString();
      String stt = state.text.toString();
      String exp = experience.text.toString();
      String mcii = mci.text.toString();
      String des = designation.text.toString();
      String base64Image="";
      if (paths!="no") {
        // final bytes = File(uploadimage!.path).readAsBytesSync();
        final bytes = File(uploadimage!.path).readAsBytesSync();
        base64Image = base64Encode(bytes);
        print("img_pan : $base64Image");
      }
      var data = await http.post(
          Uri.parse(url+"and_editexp"),
          body: {
            'nm':nm,
            "phn":phn,
            "dob":dob,
            "phn":phn,
            "eml":eml,
            "plc":plc,
            "pst":pst,
            "pn":pn,
            "dist":dist,
            "stt":stt,
            "qul":exp,
            "mci":mcii,
            "des":des,
            "lid":lid,
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
          MaterialPageRoute(builder: (context) =>  ExpertHomePage()),
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


  Future<void> _getNames() async {
    final sh = await SharedPreferences.getInstance();
    String url =sh.getString("url").toString();
    String lid =sh.getString("lid").toString();
    var data = await http.post(Uri.parse(url+"and_expert_profile"),body: {
      'lid':lid
    });
    print("------------------------------hoiiiiiii---------------");
    print(data);
    var ms = json.decode(data.body);

    var jsonData= ms['data'];




    print("Inside");
    name.text=jsonData['Name'].toString();


    // DateTime tempDate = new DateFormat("yyyy-MM-dd hh:mm:ss").parse(jsonData['v_email'].toString(););

    email.text=jsonData['Email'].toString();
    phone.text=jsonData['Mobile'].toString();
    place.text=jsonData['E_place'].toString();
    post.text=jsonData['E_post'].toString();
    pin.text=jsonData['E_pin'].toString();
    district.text=jsonData['E_District'].toString();
    state.text=jsonData['E_State'].toString();
    experience.text=jsonData['Qual'].toString();
    mci.text=jsonData['MCI/DCI_RegNo'].toString();
    designation.text=jsonData['Designation'].toString();


    url =sh.getString("url").toString();


    setState(() {


      src=url+jsonData['Certificate'].toString();
    });
    // photo= jsonData['v_photo'].toString();

    // print(photo);

  }



}
