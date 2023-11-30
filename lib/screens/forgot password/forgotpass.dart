import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'otpverify.dart';

class ResetPass extends StatefulWidget {
  const ResetPass({Key? key}) : super(key: key);

  @override
  State<ResetPass> createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {
  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<String?> takeEmailAPI(String email) async {
    final String apiUrl =
        'http://ec2-3-7-70-25.ap-south-1.compute.amazonaws.com:8006/user/resetPassword';
    var body = jsonEncode({
      "email": email,
    });

    try {
      var response = await http.post(Uri.parse(apiUrl), body: body);

      if (response.statusCode == 200) {
        print('Request for OTP successful');
        print(jsonDecode(response.body));
        return null;
      } else {
        print('Error: ${response.statusCode}');
        print(jsonDecode(response.body));
        return jsonDecode(response.body)['error'];
      }
    } catch (e) {
      print('Error: $e');
      return 'An error occurred';
    }
  }

  void _resetPassword() async {
    if (_formKey.currentState?.validate() ?? false) {
      String email = emailController.text;
      String? error = await takeEmailAPI(email);

      if (error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $error'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 0, 168, 210),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                color: Colors.white,
                child: Form(
                  key: _formKey,
                  child: Container(
                    alignment: Alignment.center,
                    width: 300,
                    child: TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email cannot be empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        hintText: "Email",
                        contentPadding: EdgeInsets.symmetric(vertical: 2.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              // ElevatedButton(
              //   onPressed: _resetPassword,
              //   child: Text('Reset Password'),
              // ),
              ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OTPVerify(
                      email: emailController.text,
                    ),
                  ),
                );
              },
              child: Text('Continue to OTP'),
            ),
            ],
          ),
        ),
      ),
    );
  }
}
