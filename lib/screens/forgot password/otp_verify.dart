import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'new_password.dart';

class OTPVerify extends StatefulWidget {
  final String email;

  const OTPVerify({super.key, required this.email});

  @override
  State<OTPVerify> createState() => _OTPVerifyState();
}

class _OTPVerifyState extends State<OTPVerify> {
  final TextEditingController otpController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<String?> takeOTPAPI(String otp) async {
    final String apiUrl =
        'http://ec2-3-7-70-25.ap-south-1.compute.amazonaws.com:8006/user/verifyOTP/${widget.email}';
    var body = jsonEncode({
      "OTP": otp,
    });
    var headers = {'Content-Type': 'application/json'};
    try {
      var response =
          await http.post(Uri.parse(apiUrl), headers: headers, body: body);

      if (response.statusCode == 200) {
        print('OTP verified');
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("OTP verified"),),);
        Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChangePassword(email: widget.email,),
        ),
      );
        print(jsonDecode(response.body));
        return null;
      } else {
        print('Error: ${response.statusCode}');
        print(jsonDecode(response.body));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${response.body}'),
            backgroundColor: Colors.red,
          ),
        );
        return jsonDecode(response.body)['error'];
      }
    } catch (e) {
      print('Error: $e');
      // return 'An error occurred';
    }
    return null;
  }

  void _verifyOTP(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      String otp = otpController.text.trim();
      String? error = await takeOTPAPI(otp);

      if (error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $error'),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text('OTP verified successfully!'),
        //     backgroundColor: Colors.green,
        //   ),
        // );
      //   Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => ChangePassword(email: widget.email,),
      //   ),
      // );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify OTP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Enter OTP sent to ${widget.email}'),
              TextFormField(
                controller: otpController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'OTP'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter OTP';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _verifyOTP(context),
                child: const Text('Verify OTP'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
