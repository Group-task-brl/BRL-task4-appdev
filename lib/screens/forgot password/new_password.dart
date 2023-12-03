import 'dart:convert';
import 'package:brl_task4/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChangePassword extends StatefulWidget {
  final String email;
  ChangePassword({required this.email});

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<String?> takePassAPI(String password, String confirmpass) async {
    // dynamic storedValue = await secureStorage.readSecureData(key);

    // if (storedValue == null) {
    //   print('Error: Authorization key not found');
    //   return 'Authorization key not found';
    // }

    final String apiUrl =
        'http://ec2-3-7-70-25.ap-south-1.compute.amazonaws.com:8006/user/newPassword/${widget.email}';

    var body = jsonEncode({
      "newPassword": password,
      "confirmPassword": confirmpass,
    });
    var headers = {
      'Content-Type': 'application/json',
      // 'Authorization': storedValue,
    };

    try {
      var response =
          await http.post(Uri.parse(apiUrl), headers: headers, body: body);

      if (response.statusCode == 200) {
        print('Password changed successfully');
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

  void _passwordchange(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      String password = newPasswordController.text;
      String? error =
          await takePassAPI(password, confirmPasswordController.text);

      if (error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $error'),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Password Changed Successfully!'),
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(),
          ),
        );
      }
    }
  }

  bool obscureText= true;
  bool obscureText2= true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: newPasswordController,
                  obscureText: obscureText,
                  decoration: InputDecoration(labelText: 'New Password',suffixIcon:  IconButton(
                                    icon: Icon(obscureText? Icons.visibility_off : Icons.visibility),
                                    onPressed:(){
                                      setState(() {
                                        obscureText = !obscureText;
                                      });
                                    },
                              ),),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: confirmPasswordController,
                  obscureText: obscureText2,
                  decoration: InputDecoration(labelText: 'Confirm Password',suffixIcon:  IconButton(
                                    icon: Icon(obscureText2? Icons.visibility_off : Icons.visibility),
                                    onPressed:(){
                                      setState(() {
                                        obscureText2 = !obscureText2;
                                      });
                                    },
                              ),),
                  validator: (value) {
                    if (value != newPasswordController.text) {
                      return 'Passwords do not match. Please re-enter the correct password.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _passwordchange(context),
                  child: Text('Reset Password'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
