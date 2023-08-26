import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:df/volunteer_editprofile.dart';

//
// void main() {
//   runApp(const JViewProfile());
// }

class ViewFilesVol extends StatelessWidget {
  const ViewFilesVol({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Job seeker',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const ViewFilesVolPage(title: 'Profile'),
    );
  }
}

class ViewFilesVolPage extends StatefulWidget {
  const ViewFilesVolPage({super.key, required this.title});


  final String title;

  @override
  State<ViewFilesVolPage> createState() => _ViewFilesVolPageState();
}

class _ViewFilesVolPageState extends State<ViewFilesVolPage> {
  final _formKey = GlobalKey<FormState>();
  String url='';
  String Result='';
  String photo1='';
  String photo2='';
  String photo3='';
  String photo4='';
  String photo5='';
  String photo6='';
  String photo7='';
  String photo8='';
  String photo9='';
  String photo10='';

  String S_status="";
  String S_product="";
  String S_frequency="";
  String S_duration="";
  String SLT_status="";
  String SLT_product="";
  String SLT_frequency="";
  String SLT_duration="";
  String A_status="";
  String A_product="";
  String A_frequency="";
  String A_duration="";
  String Sharp_teeth="";

  TextEditingController tsuggestion= new  TextEditingController();
  TextEditingController treccomendation= new TextEditingController();



  bool _isVisible=true;






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
      body:SingleChildScrollView(
        padding:  EdgeInsets.fromLTRB(8,8,8,8),
        child: Container(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Text("Survey Information"),
                SizedBox(height: 10,),

                Table(
                border: TableBorder.all(),
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(),
              1: FlexColumnWidth(),

            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: <TableRow>[


              // Text("Status"+ S_status),
              // Text("Product"+S_product),
              // Text("Frequency"+S_frequency),
              // Text("Duration"+S_duration),

              TableRow(
                children: <Widget>[
                  Container(
                    height: 30,
                    color: Colors.white,
                    child: Text('Status'),
                  ),
                  Container(
                    height: 32,
                    color: Colors.white,
                    child: Text(S_status),
                  ),
                ],
              ),
              TableRow(
                children: <Widget>[
                  Container(
                    height: 30,
                    color: Colors.white,
                    child: Text('Product'),
                  ),
                  Container(
                    height: 32,
                    color: Colors.white,
                    child: Text(S_product),
                  ),
                ],
              ),
              TableRow(
                children: <Widget>[
                  Container(
                    height: 30,
                    color: Colors.white,
                    child: Text('Frequency'),
                  ),
                  Container(
                    height: 32,
                    color: Colors.white,
                    child: Text(S_frequency),
                  ),
                ],
              ),
              TableRow(
                children: <Widget>[
                  Container(
                    height: 30,
                    color: Colors.white,
                    child: Text('Duration'),
                  ),
                  Container(
                    height: 32,
                    color: Colors.white,
                    child: Text(S_duration),
                  ),
                ],
              ),


            ],
          ),

                Text("Smokeless"),
                SizedBox(height: 10,),

                Table(
                  border: TableBorder.all(),
                  columnWidths: const <int, TableColumnWidth>{
                    0: FlexColumnWidth(),
                    1: FlexColumnWidth(),

                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: <TableRow>[

                    //
                    // Text("Status"+SLT_status),
                    // Text("Product"+SLT_product),
                    // Text("Frequency"+SLT_frequency),
                    // Text("Duration"+SLT_duration),

                    TableRow(
                      children: <Widget>[
                        Container(
                          height: 30,
                          color: Colors.white,
                          child: Text('Status'),
                        ),
                        Container(
                          height: 32,
                          color: Colors.white,
                          child: Text(SLT_status),
                        ),
                      ],
                    ),
                    TableRow(
                      children: <Widget>[
                        Container(
                          height: 30,
                          color: Colors.white,
                          child: Text('Product'),
                        ),
                        Container(
                          height: 32,
                          color: Colors.white,
                          child: Text(SLT_product),
                        ),
                      ],
                    ),
                    TableRow(
                      children: <Widget>[
                        Container(
                          height: 30,
                          color: Colors.white,
                          child: Text('Frequency'),
                        ),
                        Container(
                          height: 32,
                          color: Colors.white,
                          child: Text(SLT_frequency),
                        ),
                      ],
                    ),
                    TableRow(
                      children: <Widget>[
                        Container(
                          height: 30,
                          color: Colors.white,
                          child: Text('Duration'),
                        ),
                        Container(
                          height: 32,
                          color: Colors.white,
                          child: Text(SLT_duration),
                        ),
                      ],
                    ),


                  ],
                ),

                Text("Alchohol"),
                SizedBox(height: 10,),

                Table(
                  border: TableBorder.all(),
                  columnWidths: const <int, TableColumnWidth>{
                    0: FlexColumnWidth(),
                    1: FlexColumnWidth(),

                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: <TableRow>[

                    // Text("Status"+A_status),
                    // Text("Product"+A_product),
                    // Text("Frequency"+A_frequency),
                    // Text("Duration"+A_duration),
                    // Text("Presence of sharp teeth"+Sharp_teeth),
                    //

                    TableRow(
                      children: <Widget>[
                        Container(
                          height: 30,
                          color: Colors.white,
                          child: Text('Status'),
                        ),
                        Container(
                          height: 32,
                          color: Colors.white,
                          child: Text(A_status),
                        ),
                      ],
                    ),
                    TableRow(
                      children: <Widget>[
                        Container(
                          height: 30,
                          color: Colors.white,
                          child: Text('Product'),
                        ),
                        Container(
                          height: 32,
                          color: Colors.white,
                          child: Text(A_product),
                        ),
                      ],
                    ),
                    TableRow(
                      children: <Widget>[
                        Container(
                          height: 30,
                          color: Colors.white,
                          child: Text('Frequency'),
                        ),
                        Container(
                          height: 32,
                          color: Colors.white,
                          child: Text(A_frequency),
                        ),
                      ],
                    ),
                    TableRow(
                      children: <Widget>[
                        Container(
                          height: 30,
                          color: Colors.white,
                          child: Text('Duration'),
                        ),
                        Container(
                          height: 32,
                          color: Colors.white,
                          child: Text(A_duration),
                        ),
                      ],
                    ),
                    TableRow(
                      children: <Widget>[
                        Container(
                          height: 30,
                          color: Colors.white,
                          child: Text('SharpTeeth Status'),
                        ),
                        Container(
                          height: 32,
                          color: Colors.white,
                          child: Text(Sharp_teeth),
                        ),
                      ],
                    ),


                  ],
                ),
                SizedBox(height: 10,),
                Image.network(url+photo1,width: 300,height: 200,scale: .5,),

                SizedBox(height: 10,),
                Image.network(url+photo2,width: 300,height: 200,),

                SizedBox(height: 10,),
                Image.network(url+photo3,width: 300,height: 200,),

                SizedBox(height: 10,),
                Image.network(url+photo4,width: 300,height: 200,),

                SizedBox(height: 10,),
                Image.network(url+photo5,width: 300,height: 200,),


                SizedBox(height: 10,),
                Image.network(url+photo6,width: 300,height: 200,),

                SizedBox(height: 10,),
                Image.network(url+photo7,width: 300,height: 200,),

                SizedBox(height: 10,),
                Image.network(url+photo8,width: 300,height: 200,),

                SizedBox(height: 10,),
                Image.network(url+photo9,width: 300,height: 200,),

                SizedBox(height: 10,),
                Image.network(url+photo10,width: 300,height: 200,),

                SizedBox(height: 16.0),

                Text("Dianosis Result"),



                Text(Result),

               TextFormField(

          keyboardType: TextInputType.multiline,
          textAlignVertical: TextAlignVertical.bottom,
          maxLength: null,
          minLines: null,
          controller: tsuggestion,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 80,bottom: 12

              ),
              labelText: 'SUggestion',
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
                TextFormField(

                  keyboardType: TextInputType.multiline,
                  textAlignVertical: TextAlignVertical.bottom,
                  maxLength: null,
                  minLines: null,
                  controller:treccomendation,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 80,bottom: 12

                      ),
                      labelText: 'Reccomendation',

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
                ElevatedButton(onPressed: () {

                  sendsuggestions();

                }, child: Text('Submit')),
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
    String lid =sh.getString("ulid").toString();
    String upid =sh.getString("upid").toString();
    var data = await http.post(Uri.parse(url+"get_all_uploaded_images"),body: {
      'ulid':lid,'upid':upid
    });
    print(data);
    var ms = json.decode(data.body);

    var jsonData= ms['data'];


    setState(() {

      print("Inside");
      url =sh.getString("url").toString();
      photo1=jsonData['photo1'].toString();
      photo2=jsonData['photo2'].toString();
      photo3=jsonData['photo3'].toString();
      photo4=jsonData['photo4'].toString();
      photo5=jsonData['photo5'].toString();
      photo6=jsonData['photo6'].toString();
      photo7=jsonData['photo7'].toString();
      photo8=jsonData['photo8'].toString();
      photo9=jsonData['photo9'].toString();
      photo10= jsonData['photo10'].toString();

      S_status=jsonData['S_status'].toString();;
      S_product=jsonData['S_product'].toString();;
      S_frequency=jsonData['S_frequency'].toString();;
      S_duration=jsonData['S_duration'].toString();;
      SLT_status=jsonData['SLT_status'].toString();;
      SLT_product=jsonData['SLT_product'].toString();;
      SLT_frequency=jsonData['SLT_frequency'].toString();;
      SLT_duration=jsonData['SLT_duration'].toString();;
      A_status=jsonData['A_status'].toString();;
      A_product=jsonData['A_product'].toString();;
      A_frequency=jsonData['A_frequency'].toString();;
      A_duration=jsonData['A_duration'].toString();;
      Sharp_teeth=jsonData['Sharp_teeth'].toString();;
      Result=jsonData['result'].toString();

    });
    print(jsonData);

  }





  Future<void> _getResult() async {
    final sh = await SharedPreferences.getInstance();
    url =sh.getString("url").toString();
    String lid =sh.getString("ulid").toString();
    var data = await http.post(Uri.parse(url+"get_result2"),body: {
      'ulid':lid
    });
    print(data);
    var ms = json.decode(data.body);

    var jsonData= ms['result'];
    var id= ms['id'];
    sh.setString("upid", id);


    setState(() {

      print("Inside");
      Result=jsonData;
      _isVisible=true;


      print(jsonData);




    });
    print(jsonData);

  }


  Future<void>sendsuggestions()async{
    final sh = await SharedPreferences.getInstance();
    try{
      String url = sh.getString("url").toString();
      String upid = sh.getString("upid").toString();
      String lid = sh.getString("lid").toString();
      String suggstion= tsuggestion.text.toString();
      String reccomendation= treccomendation.text.toString();


      var data = await http.post(
          Uri.parse(url+"updateresult"),
          body: {
            'id':upid,
            'suggestion':suggstion,
            'recommendation':reccomendation,
            'lid':lid,
          });
      print(data);
      var jasondata = json.decode(data.body);
      String status=jasondata['status'].toString();

      if(status=="ok"){

        // if(utype=='Job_seeker'){
        Fluttertoast.showToast(
            msg: "Send Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 12.0
        );
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) =>  VolunteerHomePage()),
        // );
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





