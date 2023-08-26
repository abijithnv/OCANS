import 'dart:async';
import 'package:flutter/material.dart';
import 'package:df/login.dart';
import 'package:df/public_resultpage.dart';
import 'package:df/signup.dart';
import 'package:df/v_home.dart';
import 'package:df/volunteer_signup.dart';
import 'package:df/expert_signup.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'UserResultPage.dart';
import 'ipsettings.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cancer Screening App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashPage(),
      // initialRoute: '/',
      routes: {
        // '/': (context) => SplashPage(),
        // '/volunteer_signup': (context) => VolunteerSignupPage(),
        // '/expert_signup': (context) => ExpertSignupPage(),
        // '/v_home': (context) => VolunteerHomePage(),
      },
    );
  }
}

class SplashPage extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      // After 3 seconds, navigate to the home screen.
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Ippage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue, // Set your desired background color
      body: Column(
            children: [
              Image(image: NetworkImage('https://blog.bonfire.com/wp-content/uploads/2019/06/Head-and-Neck-Cancer-Ribbon.png'),),
              Text('OCANS',
                style: TextStyle(fontSize: 40.0, color: Color(0xFFfef0df),),
              )
            ],
          )

    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(15,35,5,10),
                child: Row(
                  children: [
                    Text(
                      'Welcome to OCANS',
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Image(
                      image: NetworkImage(
                          'https://blog.bonfire.com/wp-content/uploads/2019/06/Head-and-Neck-Cancer-Ribbon.png'),
                      width: 45,),
                  ],
                ),
              ),
              CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  enlargeCenterPage: true,
                  viewportFraction: 0.8,
                ),
                items: [
                  Image(image: NetworkImage(
                      'https://dentistkansascityks.com/wp-content/uploads/2023/04/oral-cancer-screenings.jpg'),),
                  Image(image: NetworkImage(
                      'http://c2-preview.prosites.com/197067/ed/Blog/bd248a05-76ca-41e9-9184-b71fa12f2c9b.png'),),
                  Image(image: NetworkImage(
                      'https://treatmentpossible.com/wp-content/uploads/2020/12/what-are-the-symptoms-of-oral-cancer-infographics.jpg'),),
                  Image(image: NetworkImage(
                      'https://gpsdentalsa.com/wp-content/uploads/2018/01/dental-health-awareness.png'),),
                  // Add more images as per your requirement
                ],
              ),
              SizedBox(height: 24.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(22.0),
                      child: Text(
                        'Our Services',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      mainAxisSpacing: 20.0,
                      crossAxisSpacing: 20.0,
                      childAspectRatio: 2.5, //adjust for button size
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => UserResultPage()),
                            );// View My Results functionality here
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            // Set the gradient colors for the button
                            onPrimary: Colors.white,
                          ),
                          child: Text('View My Results'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // About OCANS Screenings functionality here
                          },
                          child: Text('About OCANS'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LoginPage()),
                            );// Login functionality here
                          },
                          child: Text('Login'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignupPage()),
                            );// Sign Up functionality here
                          },
                          child: Text('Sign Up'),
                        ),
                      ],
                    ),
                    SizedBox(height: 32.0),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'FAQs',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    ExpansionTile(
                      title: Text("What is Oral cancer?"),
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text("answer"),
                        ),
                      ],
                    ),
                    ExpansionTile(
                      title: Text("What causes Oral cancer?"),
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text("answer"),
                        ),
                      ],
                    ),
                    ExpansionTile(
                      title: Text("Am I at risk of having Oral cancer?"),
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text("answer"),
                        ),
                      ],
                    ),
                    ExpansionTile(
                      title: Text("What is Oral cancer screening?"),
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text("answer"),
                        ),
                      ],
                    ),
                    ExpansionTile(
                      title: Text("When should I take a screening test?"),
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text("answer"),
                        ),
                      ],
                    ),
                    ExpansionTile(
                      title: Text("When should I see a doctor?"),
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text("answer"),
                        ),
                      ],
                    ),
                    // Add more FAQ tiles as needed
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
