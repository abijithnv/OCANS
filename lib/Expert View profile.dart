import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:df/volunteer_editprofile.dart';

import 'expert_editprofile.dart';

//
// void main() {
//   runApp(const JViewProfile());
// }

class EProfile extends StatelessWidget {
  const EProfile({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Job seeker',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const EProfilePage(title: 'Profile'),
    );
  }
}

class EProfilePage extends StatefulWidget {
  const EProfilePage({super.key, required this.title});


  final String title;

  @override
  State<EProfilePage> createState() => _EProfilePageState();
}

class _EProfilePageState extends State<EProfilePage> {
  final _formKey = GlobalKey<FormState>();
  String url='';
  String photo='';
  String name='';
  String email='';
  String phone='';
  String place='';
  String post='';
  String pin='';
  String dist='';
  String state='';


  // String formatted='';
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
      body:Padding(
        padding:  EdgeInsets.fromLTRB(8,8,8,8),
        child: Card(
          child: Container(
            height:700,
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 80.0,
                  backgroundImage: NetworkImage(url+photo),
                ),
                SizedBox(height: 16.0),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),

                SizedBox(height: 16.0),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.email),
                    title: Text(email),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.phone),
                    title: Text(phone),
                  ),
                ),

                Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.location_on),
                        title: Row(
                          children: [
                            Text(place+","),SizedBox(width: 5,),
                            Text(post+","),
                          ],
                        ),
                        subtitle: Row(
                          children: [
                            Text(dist+","),SizedBox(width: 5,),
                            Text(state+","),SizedBox(width: 5,),
                            Text(pin,style: TextStyle(fontWeight: FontWeight.bold),),SizedBox(width: 5,),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                    child:ElevatedButton(onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  ExpEditProfile ()),
                      );
                    },child: Icon(Icons.edit),)
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }



  Future<void> _getNames() async {
    final sh = await SharedPreferences.getInstance();
    url =sh.getString("url").toString();
    String lid =sh.getString("lid").toString();
    var data = await http.post(Uri.parse(url+"and_expert_profile"),body: {
      'lid':lid
    });
    print("------------------------------hoiiiiiii---------------");
    print(data);
    var ms = json.decode(data.body);

    var jsonData= ms['data'];


    setState(() {

      print("Inside");
      url =sh.getString("url").toString();
      name=jsonData['Name'].toString();
      email=jsonData['Email'].toString();
      phone=jsonData['Mobile'].toString();
      place=jsonData['E_place'].toString();
      post=jsonData['E_post'].toString();
      pin=jsonData['E_Pin'].toString();
      dist=jsonData['E_District'].toString();
      state=jsonData['E_State'].toString();
      photo= jsonData['Certificate'].toString();
      // final DateFormat formatter = DateFormat('yyyy-MM-dd');
      // formatted = formatter.format(dob as DateTime);


      print(photo);

    });
    print(jsonData);

  }
}
