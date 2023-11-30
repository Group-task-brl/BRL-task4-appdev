import 'package:flutter/material.dart';

class OTPVerify extends StatelessWidget {
  final String email;
  final TextEditingController otpController = TextEditingController();

  OTPVerify({required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify OTP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Enter OTP sent to $email'),
            TextField(
              controller: otpController,
              decoration: InputDecoration(labelText: 'OTP'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => 
                //   ),
                // );
              },
              child: Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
