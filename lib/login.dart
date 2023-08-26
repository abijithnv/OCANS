import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:df/signup.dart';
import 'package:df/u_home.dart';
import 'package:df/v_home.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'expert_home.dart';
import 'main.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  // final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
        onWillPop: () async {
          // Add your logic here for handling the back button press
          // Navigate back to the login page when the back button is pressed
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyApp()),
          );
          // Prevent the default back navigation
          return false;
        },

        child: Scaffold(
      body: SingleChildScrollView(
        child:Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.grey[200],
        ),
        margin: EdgeInsets.fromLTRB(20.0,100.0,20.0,100.0),
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Login',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            TextFormField(
              // validator: (v){
              //   if (v!.isEmpty) {
              //     return 'Please enter your username';
              //   }
              //   return null;
              // },
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              // validator: (v){
              //   if (v!.isEmpty) {
              //     return 'Please enter your password';
              //   }
              //   return null;
              // },

              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              obscureText: true,
            ),
            SizedBox(height: 10.0),
            // TextButton(
            //   onPressed: () {
            //     // TODO: Implement forgot password functionality
            //   },
            //   child: Text(
            //     'Forgot Password?',
            //     style: TextStyle(color: Colors.blue),
            //   ),
            // ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () async {



                // if (_formKey.currentState!.validate()) {
                  final sh = await SharedPreferences.getInstance();
                  try{

                    String uname=emailController.text;
                    String paswrd=passwordController.text;

                    String url = sh.getString("url").toString();
                    // String url="http://192.168.167.202:3000/";

                    var data = await http.post(
                        Uri.parse(url+"and_login"),
                        body: {'username':uname,
                          "password":paswrd,
                        });
                    print(data);
                    var jasondata = json.decode(data.body);
                    String status=jasondata['status'].toString();

                    if(status=="ok"){
                      String utype=jasondata['type'].toString();
                      String lid = jasondata['lid'].toString();
                      sh.setString("lid", lid);
                      if(utype=='volunteer'){
                        Fluttertoast.showToast(
                            msg: "Login success",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.grey,
                            textColor: Colors.white,
                            fontSize: 12.0
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => VolunteerHomePage()),
                        );

                      }else if(utype=='user'){

                        String vlid=jasondata['vlid'].toString();
                        sh.setString("dlid", vlid);
                        print(vlid);
                        Fluttertoast.showToast(
                            msg: "Login success",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.grey,
                            textColor: Colors.white,
                            fontSize: 12.0
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => UserHomePage()),
                        );

                      }

                      else if(utype=='expert'){
                        Fluttertoast.showToast(
                            msg: "Login success",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.grey,
                            textColor: Colors.white,
                            fontSize: 12.0
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ExpertHomePage()),
                        );

                      }



                      else{
                        Fluttertoast.showToast(
                            msg: "Login rejected",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.grey,
                            textColor: Colors.white,
                            fontSize: 12.0
                        );

                      }



                    }
                    else{
                      Fluttertoast.showToast(
                          msg: "No user found.. pleasse register",
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
              child: Text('Login'),
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?"),
                SizedBox(width: 5.0),
                TextButton(
                  onPressed: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupPage()),
                    );
                    // TODO: Implement sign up functionality
                  },
                  child: Text(
                    'Sign up',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
    ),

        );
  }


}

