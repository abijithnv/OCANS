import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:df/Send%20complaint.dart';

void main() {
  runApp(const UserViewComplaints());
}

class UserViewComplaints extends StatelessWidget {
  const UserViewComplaints({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Complaints',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const UserViewComplaintsPage(title: 'Complaints'),
    );
  }
}

class UserViewComplaintsPage extends StatefulWidget {
  const UserViewComplaintsPage({super.key, required this.title});


  final String title;

  @override
  State<UserViewComplaintsPage> createState() => _UserViewComplaintsPageState();
}

class _UserViewComplaintsPageState extends State<UserViewComplaintsPage> {
  final _formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Container(
          padding: EdgeInsets.all(5.0),
          child: FutureBuilder(
              future: _getdata(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                print("snapshot" + snapshot.toString());
                if (snapshot.data == null) {
                  return Container(
                    child: Center(
                      child: Text("Loading..."),
                    ),
                  );
                } else {
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    // padding: EdgeInsets.all(5.0),
                    // shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return
                        ListTile(
                          title:
                          Card(
                          child: IntrinsicHeight(
                            child: Container(

                              padding: EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    blurRadius: 4.0,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [


                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Complaint:',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                    ],
                                  ),

                                  SizedBox(height: 10.0),

                                  Container(
                                    child:
                                    Text(
                                      snapshot.data[index].complaint,
                                      style: TextStyle(fontSize: 16.0),
                                    ),



                                  ),



                                  SizedBox(height: 20.0),


                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Reply:',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                    ],
                                  ),
                                  SizedBox(height: 10.0),

                                  Container(
                                    child:
                                    Text(
                                      snapshot.data[index].reply,
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                  ),


                                  SizedBox(height: 20.0),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Date:',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        snapshot.data[index].date,
                                        style: TextStyle(fontSize: 16.0),
                                      ),

                                    ],
                                  ),



                                ],


                              ),
                            ),
                          ),
                          ),
                        );
                    },
                  );
                }
              })
      ),
      floatingActionButton: FloatingActionButton(
      onPressed:(){
        Navigator.push(context,  MaterialPageRoute(builder: (context) => SendComplaint()));

      },
      tooltip: 'Increment',
      child: const Icon(Icons.add),
    ),
    );
  }


  Future<List<UserFeedbacks>> _getdata() async {
    final sh = await SharedPreferences.getInstance();
    String Url = sh.getString("url").toString();
    String lid = sh.getString("lid").toString();
    var data = await http.post(Uri.parse(Url+"user_view_complaints"),body: {
      'lid':lid,
    });
    print("------------------------------hoiiiiiii---------------");
    print(data);
    var jsonData = json.decode(data.body);

    print(jsonData);
    List<UserFeedbacks> jokes = [];
    for (var i in jsonData["data"]) {
      print(i);
      UserFeedbacks newname =
      UserFeedbacks(i['complaint'].toString(),i['date'].toString(),i['reply'].toString(),i['status'].toString(),i['u_lid'].toString());
      jokes.add(newname);
    }
    return jokes;
  }
}

class UserFeedbacks{
  late final String complaint;
  late final String date;
  late final String reply;
  late final String status;
  late final String u_lid;
  UserFeedbacks(this.complaint,this.date,this.reply,this.status,this.u_lid);
}