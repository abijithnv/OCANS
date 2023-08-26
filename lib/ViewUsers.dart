import 'dart:convert';
import 'dart:math';
import 'package:df/v_home.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:df/predict_based_photo.dart';
import 'package:df/surveylik.dart';
import 'package:df/surveylik2.dart';

import 'adduser.dart';
import 'chat.dart';
import 'edituser.dart';


void main() {
  runApp(const ViewUsers());
}

class ViewUsers extends StatelessWidget {
  const ViewUsers({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const ViewUsersPage(title: 'Flutter Demo Home Page'),
      routes: {

      },
    );
  }
}

class ViewUsersPage extends StatefulWidget {
  const ViewUsersPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<ViewUsersPage> createState() => _ViewUsersPageState();
}

class _ViewUsersPageState extends State<ViewUsersPage> {
  int _counter = 0;

  _ViewUsersPageState() {
    view_users();
  }

  List<String> user_id_ = <String>[];
  List<String> login_id_ = <String>[];
  List<String> user_name_ = <String>[];
  List<String> dob_ = <String>[];
  List<String> gender_ = <String>[];
  List<String> place_ = <String>[];
  List<String> email_ = <String>[];
  List<String> phone_ = <String>[];
  List<String> post_ = <String>[];
  List<String> pin_ = <String>[];
  List<String> photo_ = <String>[];
  List<String> dist_ = <String>[];
  List<String> state_ = <String>[];

  Future<void> view_users() async {
    List<String> user_id = <String>[];
    List<String> login_id = <String>[];
    List<String> user_name = <String>[];
    List<String> place = <String>[];
    List<String> email = <String>[];
    List<String> phone = <String>[];
    List<String> post = <String>[];
    List<String> pin = <String>[];
    List<String> dist = <String>[];
    List<String> state = <String>[];
    List<String> photo = <String>[];
    List<String> dob = <String>[];
    List<String> gender = <String>[];

    try {
      final pref=await SharedPreferences.getInstance();
      String ip= pref.getString("ip").toString();
      String lid= pref.getString("lid").toString();

      String url="http://"+ip+":3000/and_view_users";

      var data = await http.post(Uri.parse(url), body: {

        'vlid':lid,

      });
      var jsondata = json.decode(data.body);
      String status = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {

        print(arr[i]);
        user_id.add(arr[i]['v_lid'].toString());

        login_id.add(arr[i]['u_lid'].toString());
        print("1");
        user_name.add(arr[i]['u_name']);
        print("2");
        place.add(arr[i]['u_place']);
        print("3");
        email.add(arr[i]['u_email']);
        print("4");
        phone.add(arr[i]['u_phone'].toString());
        print("5");
        post.add(arr[i]['u_post']);
        print("6");
        pin.add(arr[i]['u_pin'].toString());
        print("7");
        dist.add(arr[i]['u_district']);
        print("8");
        state.add(arr[i]['u_state'].toString());
        print("9");
        dob.add(arr[i]['u_dob'].toString());
        print("10");
        gender.add(arr[i]['u_gender']);
        print("1");
        photo.add("http://"+ip+":3000" + arr[i]['u_photo']);
      }

      setState(() {
        user_id_ = user_id;
        login_id_ = login_id;
        user_name_ = user_name;
        place_ = place;
        email_ = email;
        phone_ = phone;
        dob_=dob;
        post_=post;
        pin_=pin;
        photo_ = photo;
        gender_ = gender;
        dist_ = dist;
        state_ = state;
      });

      print(status);
    } catch (e) {
      print("Error ------------------- " + e.toString());
      //there is error during converting file image to base64 encoding.
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
            title: new Text(
              "List of Users",
              style: new TextStyle(color: Colors.white),
            ),
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () {
                // Navigator.pop(context);
                // Navigator.pushNamed(context, '/home');
                Navigator.push(context, MaterialPageRoute(builder: (context) =>   VolunteerHomePage()),);
                print("Hello");
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => ThirdScreen()),
                // );
              },
            )
        ),
        floatingActionButton: FloatingActionButton(
          onPressed:(){
            Navigator.push(context,  MaterialPageRoute(builder: (context) => UserSignup()));

          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
        body: ListView.builder(
          physics: BouncingScrollPhysics(),
          // padding: EdgeInsets.all(5.0),
          // shrinkWrap: true,
          itemCount: user_name_.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onLongPress: () {
                print("long press" + index.toString());
              },
              title: Padding(
                  padding: const EdgeInsets.all(0.5),
                  child: Column(
                    children: [


                      Container(
                        width: MediaQuery. of(context). size. width,

                        child: Card(

                          clipBehavior: Clip.antiAliasWithSaveLayer,

                          child: IntrinsicHeight(
                          child: Column(
                            children: [


                              Align(
                                alignment: Alignment.topRight,
                                child:


                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,

                                  children: [
                                    SizedBox(width: 10,),


                                    ElevatedButton(
                                      child: Text("Edit"),
                                      onPressed: () async {

                                        final pref=await SharedPreferences.getInstance();

                                        pref.setString("dlid",login_id_.elementAt(index).toString());

                                        // Navigator.pushNamed(context, "/send_review");
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => const UserEditProfile()),);

                                      },
                                    ),
                                    SizedBox(width: 10,),
                                    ElevatedButton(
                                      child: Text("Delete"),
                                      onPressed: () async {

                                        final pref=await SharedPreferences.getInstance();

                                        // pref.setString("dlid",login_id_.elementAt(index).toString());                                                String ulid=pref.getString("dlid").toString();
                                        // String lid= pref.getString("dlid").toString();
                                        String lid= login_id_.elementAt(index).toString();
                                        DeleteUser(lid);

                                      },
                                    ),
                                    SizedBox(width: 10,),



                                  ],
                                ),),


                              SizedBox(height: 5,),

                              Container(
                                padding: EdgeInsets.all(5),
                                child:  SizedBox(
                                  width: MediaQuery. of(context). size. width,
                                  height: 250,
                                  child: Image.network(
                                    photo_[index],
                                    fit: BoxFit.fill,
                                  ),
                                ),

                              ),
                              SizedBox(height: 16,),
                              Row(

                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),

                                  Flexible(flex: 2, fit: FlexFit.loose, child: Row(children: [Text("Name")])),
                                  Flexible(flex: 3, fit: FlexFit.loose, child: Row(children: [Text(user_name_[index])])),

                                  // Text("Place"),
                                  // Text(place_[index])
                                ],
                              ),

                              SizedBox(height: 16,),
                              Row(

                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),

                                  Flexible(flex: 2, fit: FlexFit.loose, child: Row(children: [Text("Post")])),
                                  Flexible(flex: 3, fit: FlexFit.loose, child: Row(children: [Text(post_[index])])),

                                  // Text("Place"),
                                  // Text(place_[index])
                                ],
                              ),
                              SizedBox(height: 9,),
                              Row(

                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),

                                  Flexible(flex: 2, fit: FlexFit.loose, child: Row(children: [Text("District")])),
                                  Flexible(flex: 3, fit: FlexFit.loose, child: Row(children: [Text(dist_[index])])),

                                  // Text("Place"),
                                  // Text(place_[index])
                                ],
                              ),
                              SizedBox(height: 9,),
                              Row(

                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),

                                  Flexible(flex: 2, fit: FlexFit.loose, child: Row(children: [Text("State")])),
                                  Flexible(flex: 3, fit: FlexFit.loose, child: Row(children: [Text(state_[index])])),

                                  // Text("Place"),
                                  // Text(place_[index])
                                ],
                              ),
                              SizedBox(height: 9,),
                              Row(

                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),

                                  Flexible(flex: 2, fit: FlexFit.loose, child: Row(children: [Text("Pincode")])),
                                  Flexible(flex: 3, fit: FlexFit.loose, child: Row(children: [Text(pin_[index])])),

                                  // Text("Place"),
                                  // Text(place_[index])
                                ],
                              ),

                              Row(

                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),

                                  ElevatedButton(
                                    child: Text("Screening"),
                                    onPressed: () async {

                                      final pref=await SharedPreferences.getInstance();

                                      pref.setString("ulid",login_id_.elementAt(index).toString());


                                      // Navigator.pushNamed(context, "/view_doctor_schedule");


                                      Navigator.push(
                                        context,
                                        // Navigator.push(context, MaterialPageRoute(builder: (context) => const ImageUpload()),);
                                        MaterialPageRoute(builder: (context) => VolSurveynew()),
                                        // MaterialPageRoute(builder: (context) => ImageUpload()),
                                      );//


                                      // Navigator.push(context, MaterialPageRoute(builder: (context) => const ImageUpload()),);

                                    },
                                  ),


                                  SizedBox(width: 10,),
                                  ElevatedButton(
                                    child: Text("Upload"),
                                    onPressed: () async {

                                      final pref=await SharedPreferences.getInstance();

                                      pref.setString("ulid",login_id_.elementAt(index).toString());


                                      // Navigator.pushNamed(context, "/view_doctor_schedule");


                                      Navigator.push(
                                        context,
                                        // Navigator.push(context, MaterialPageRoute(builder: (context) => const ImageUpload()),);
                                        MaterialPageRoute(builder: (context) => VolSurveynewnew()),
                                        // MaterialPageRoute(builder: (context) => ImageUpload()),
                                      );//


                                      // Navigator.push(context, MaterialPageRoute(builder: (context) => const ImageUpload()),);

                                    },
                                  ),
                                  // Text("Place"),
                                  // Text(place_[index])
                                ],
                              ),

                              // Column(
                              //     mainAxisAlignment: MainAxisAlignment.start,
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     children:[
                              //   Text('Title'),
                              //   Text('Subtitle')
                              // ])
                            ],
                          ),

                          ),




                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          margin: EdgeInsets.all(10),
                        ),
                      ),

                      // Card(
                      //   child: Container(
                      //     height: 240,
                      //     width: 450,
                      //     color: Colors.white,
                      //     child: Row(
                      //       children: [
                      //         Center(
                      //           child: Padding(
                      //             padding: EdgeInsets.all(4),
                      //             child: Expanded(
                      //               child: Image.network(
                      //                 photo_[index],
                      //                 width: 60,
                      //                 height: 60,
                      //                 scale: .5,
                      //               ),
                      //               flex: 2,
                      //             ),
                      //           ),
                      //         ),
                      //         Expanded(
                      //           child:
                      //
                      //           Container(
                      //             alignment: Alignment.topLeft,
                      //             child: Column(
                      //               children: [
                      //                 Expanded(
                      //                   flex: 5,
                      //                   child: ListTile(
                      //                     title: Text(user_name_[index]),
                      //                     subtitle:
                      //                     Column(
                      //                       mainAxisAlignment: MainAxisAlignment.start,
                      //                       crossAxisAlignment: CrossAxisAlignment.start,
                      //                       children: [
                      //                         SizedBox(height: 10,),
                      //                         Text(place_[index]),
                      //                         Text(post_[index]),
                      //                         Text(pin_[index]),
                      //                         Text(dist_[index]),
                      //                         Text(state_[index]),
                      //                         SizedBox(height: 10,)
                      //                       ],
                      //                     ),
                      //                   ),),
                      //                 Expanded(
                      //                   flex: 5,
                      //                   child: Row(
                      //                     mainAxisAlignment:
                      //                     MainAxisAlignment.center,
                      //                     children: [
                      //
                      //                       ElevatedButton(
                      //                         child: Text("Upload"),
                      //                         onPressed: () async {
                      //
                      //                           final pref=await SharedPreferences.getInstance();
                      //
                      //                           pref.setString("ulid",login_id_.elementAt(index).toString());
                      //
                      //
                      //                           // Navigator.pushNamed(context, "/view_doctor_schedule");
                      //
                      //
                      //                           Navigator.push(
                      //                             context,
                      //                             // Navigator.push(context, MaterialPageRoute(builder: (context) => const ImageUpload()),);
                      //                             MaterialPageRoute(builder: (context) => VolSurveynew()),
                      //                             // MaterialPageRoute(builder: (context) => ImageUpload()),
                      //                           );//
                      //
                      //
                      //                           // Navigator.push(context, MaterialPageRoute(builder: (context) => const ImageUpload()),);
                      //
                      //                         },
                      //                       ),
                      //
                      //                       // ElevatedButton(
                      //                       //   child: Text("Chat"),
                      //                       //   onPressed: () async {
                      //                       //
                      //                       //     final pref=await SharedPreferences.getInstance();
                      //                       //
                      //                       //     pref.setString("dlid",login_id_.elementAt(index).toString());
                      //                       //     pref.setString("name",user_name_.elementAt(index).toString());
                      //                       //
                      //                       //     // Navigator.pushNamed(context, "/chat");
                      //                       //     Navigator.push(context, MaterialPageRoute(builder: (context) => const MyChatPage(title: '',)),);
                      //                       //
                      //                       //   },
                      //                       // ),
                      //                       ElevatedButton(
                      //                         child: Text("Edit"),
                      //                         onPressed: () async {
                      //
                      //                           final pref=await SharedPreferences.getInstance();
                      //
                      //                           pref.setString("dlid",login_id_.elementAt(index).toString());
                      //
                      //                           // Navigator.pushNamed(context, "/send_review");
                      //                           Navigator.push(context, MaterialPageRoute(builder: (context) => const UserEditProfile()),);
                      //
                      //                         },
                      //                       ),
                      //
                      //
                      //                       ElevatedButton(
                      //                         child: Text("Delete"),
                      //                         onPressed: () async {
                      //
                      //                           final pref=await SharedPreferences.getInstance();
                      //
                      //                           // pref.setString("dlid",login_id_.elementAt(index).toString());                                                String ulid=pref.getString("dlid").toString();
                      //                           // String lid= pref.getString("dlid").toString();
                      //                           String lid= login_id_.elementAt(index).toString();
                      //                           DeleteUser(lid);
                      //
                      //                         },
                      //                       ),
                      //
                      //
                      //
                      //                       SizedBox(
                      //                         width: 8,)
                      //
                      //
                      //
                      //
                      //
                      //                     ],
                      //                   ),
                      //                 )
                      //               ],
                      //             ),
                      //           ),
                      //           flex: 8,
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      //   elevation: 8,
                      //   margin: EdgeInsets.all(10),
                      // ),
                    ],
                  )),
            );
          },

        )


      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }



  Future<void>DeleteUser(ulid)async{
    final ips = await SharedPreferences.getInstance();
    try{
      String url = ips.getString("url").toString();

      var data = await http.post(
          Uri.parse(url+"delete_user"),
          body: {

            'lid':ulid,

          });
      print(data);
      var jasondata = json.decode(data.body);
      String status=jasondata['status'].toString();

      if(status=="ok"){

        Fluttertoast.showToast(
            msg: "Deleted",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 12.0
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ViewUsers()),
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
