import 'package:flutter/material.dart';
import 'package:df/signup.dart';
import 'package:df/v_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class Ippage extends StatelessWidget {
  final TextEditingController ipController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              'Ip Settings',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: ipController,
              decoration: InputDecoration(
                labelText: 'Ip address',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 10.0),

            SizedBox(height: 10.0),

            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () async {
                // Perform login logic here
                String ip = ipController.text;
                // TODO: Add your authentication logic here
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString('ip', ip);
                prefs.setString('url', "http://"+ip+":3000/");


                Navigator.push(
                  context,

                  MaterialPageRoute(builder: (context) => HomePage()),
                );

                // Example validation

              },
              child: Text('Save'),
            ),
            SizedBox(height: 10.0),

          ],
        ),
      ),
    ),
    );
  }
}
