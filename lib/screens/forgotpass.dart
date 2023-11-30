import 'dart:convert';

import 'package:brl_task4/models/storeToken.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/storeToken.dart';
import '../utils/Routes.dart';

class ResetPass extends StatefulWidget {
  const ResetPass({super.key});

  @override
  State<ResetPass> createState() => _ResetPassState();
}

final SecureStorage secureStorage = SecureStorage();
String key = 'accessToken';

class _ResetPassState extends State<ResetPass> {

  TextEditingController emailController = TextEditingController();
   final _formKey = GlobalKey<FormState>();

  Future<void> TakePasswordAPI() async {
    final String apiUrl =
        'http://ec2-3-7-70-25.ap-south-1.compute.amazonaws.com:8006/user/resetPassword';
    final response = await http.post(Uri.parse(apiUrl),
        body: ({
          'email': emailController.text,
        }));
    print(response.body);
    if (response.statusCode == 200) {
      dynamic generateResponse = jsonDecode(response.body);
      Token.fromJson(generateResponse);
      await secureStorage.writeSecureData(key, generateResponse);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${response.body}"),
        ),
      );
      print('API Response: ${response.body}');
      await Navigator.pushNamed(context, MyRoutes.LoginRoutes);
    } else {
      print('Failed. Status Code: ${response.statusCode}');
      print('Error: ${response.body}');
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Container(
          // child: Center(child: Text('Hi',style: TextStyle(fontSize: 20),)),
          child: Form(
              key: _formKey,
              child: Container(
                width: 290,
                color: Colors.grey,
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined),
                    hintText: "Email",
                    contentPadding: EdgeInsets.symmetric(vertical: 2.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              )),
        ),
      );
    }
  }

  // Widget TakePassword(){

  // }
}
