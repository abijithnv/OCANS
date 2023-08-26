import 'package:flutter/material.dart';
import 'package:df/main.dart';

class ScreeningResultsPage extends StatefulWidget {
  @override
  _ScreeningResultsPageState createState() => _ScreeningResultsPageState();
}

class _ScreeningResultsPageState extends State<ScreeningResultsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _screeningIdController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Perform validation logic and check if the screening ID is valid

      String screeningId = _screeningIdController.text;

      // Validate the screening ID here (e.g., make an API call)

      if (isValidScreeningId(screeningId)) {
        // Redirect to OTP page if the screening ID is valid
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OTPPage()),
        );
      } else {
        // Show an error popup if the screening ID is invalid
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Invalid Screening ID'),
              content: Text('Please try again with a valid screening ID.'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  bool isValidScreeningId(String screeningId) {
    // Implement your validation logic here (e.g., API call, database check, etc.)
    // Return true if the screening ID is valid, false otherwise

    // Placeholder logic (assuming screening ID is valid if it has 8 characters)
    return screeningId.length == 8;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Screening Results',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 16.0),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        SizedBox(height: 16.0),
                        Text(
                          'To view and download your screening results, please enter your SCREENING ID:',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              TextFormField(
                                controller: _screeningIdController,
                                decoration: InputDecoration(
                                  labelText: 'Screening ID',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your Screening ID';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 16.0),
                              ElevatedButton(
                                onPressed: _submitForm,
                                child: Text('Get Results'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16.0,),
                IconButton(
                  icon: Icon(Icons.arrow_back_ios_new_rounded),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );// Edit profile functionality here
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OTPPage extends StatefulWidget {
  @override
  _OTPPageState createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  TextEditingController _otpController = TextEditingController();

  void _submitForm() {
    String otp = _otpController.text;
    // Validate the OTP here (e.g., make an API call)
    if (isValidOTP(otp)) {
      // OTP is valid
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('OTP is valid!'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      // OTP is invalid
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Invalid OTP'),
            content: Text('Please try again with a valid OTP.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ScreeningResultsPage()),
                  );
                },
              ),
            ],
          );
        },
      );
    }
  }

  bool isValidOTP(String otp) {
    // Implement your validation logic here
    // Return true if the OTP is valid, false otherwise
    // Example placeholder logic: OTP should be 4 digits long
    return otp.length == 4;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Enter the OTP sent to your mobile number:',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 16.0),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _otpController,
                          keyboardType: TextInputType.number,
                          maxLength: 4,
                          decoration: InputDecoration(
                            labelText: 'OTP',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter the OTP';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: _submitForm,
                          child: Text('Submit'),
                        ),
                        SizedBox(height: 16.0),
                        TextButton(
                          onPressed: () {
                            // Resend OTP logic
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Resend OTP'),
                                  content: Text('Resend OTP logic goes here.'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Text('Not received? Resend OTP'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
