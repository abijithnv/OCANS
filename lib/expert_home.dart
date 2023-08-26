import 'package:flutter/material.dart';
import 'package:df/login.dart';
import 'package:df/screenpage1.dart';
import 'package:df/volunteer_profile.dart';
import 'Expert View profile.dart';
import 'User View profile.dart';
import 'ViewUsersExp.dart';

class ExpertHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return WillPopScope(
        onWillPop: () async {
          // Add your logic here for handling the back button press
          // Navigate back to the login page when the back button is pressed
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
          // Prevent the default back navigation
          return false;
        },



    child: Scaffold(
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back, User.',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: GridView.count(
                crossAxisCount: 1,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 2.0,
                children: [
                  ElevatedButton(
                    child: Column(
                      children: [
                        SizedBox(height: 10.0),
                        Image(image: NetworkImage('https://cdn-icons-png.flaticon.com/128/387/387561.png')),
                        SizedBox(height: 10.0),
                        Text('Profile'),
                      ],
                    ),// add image
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EProfile()),
                      );// Add your logic for Start Screening button here
                    },
                  ),
                  ElevatedButton(
                    child: Column(
                      children: [
                        SizedBox(height: 10.0),
                        Image(image: NetworkImage('https://cdn-icons-png.flaticon.com/128/2854/2854545.png')),
                        SizedBox(height: 10.0),
                        Text('Users'),
                      ],
                    ),// add image
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ViewUsersExp()),
                      );// Add your logic for Start Screening button here
                    },
                  ),
                  ElevatedButton(
                    child: Column(
                      children: [
                        SizedBox(height: 10.0),
                        Image(image: NetworkImage('https://cdn-icons-png.flaticon.com/128/1716/1716282.png')),
                        SizedBox(height: 10.0),
                        Text('Logout'),
                      ],
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );// Add your logic for Logout button here
                    },
                  ),
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
