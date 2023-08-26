import 'package:flutter/material.dart';
import 'package:df/chat.dart';
import 'package:df/login.dart';
import 'package:df/screenpage1.dart';
import 'package:df/volunteer_profile.dart';

import 'User View profile.dart';
import 'User view Volunteer View profile.dart';

class UserHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        SizedBox(height: 20.0),
                        Image(image: NetworkImage('https://cdn-icons-png.flaticon.com/128/3140/3140300.png')),
                        SizedBox(height: 10.0),
                        Text('Chat with volunteer'),
                      ],
                    ),// add image
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UserVolunteerViewProfile()),
                      );// Add your logic for Start Screening button here
                    },
                  ),
                  ElevatedButton(
                    child: Column(
                      children: [
                        SizedBox(height: 20.0),
                        Image(image: NetworkImage('https://cdn-icons-png.flaticon.com/128/881/881760.png')),
                        SizedBox(height: 10.0),
                        Text('My Profile'),
                      ],
                    ),// add image
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UserViewProfile()),
                      );// Add your logic for Start Screening button here
                    },
                  ),
                  ElevatedButton(
                    child: Column(
                      children: [
                        SizedBox(height: 20.0),
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
    );
  }
}
