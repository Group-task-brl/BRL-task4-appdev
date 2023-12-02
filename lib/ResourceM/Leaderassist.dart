// import 'dart:convert';

// import 'package:brl_task4/screens/login.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class LEaderR extends StatefulWidget {
//   final String teamId;
//   LEaderR( this.teamId);
  

//   @override
//   State<LEaderR> createState() => _LEaderRState();
// }

// class _LEaderRState extends State<LEaderR> {

//   TextEditingController message = TextEditingController();
//   TextEditingController emailSender = TextEditingController();


//   Future<void> leaderAss() async {

//     String storedValue = await secureStorage.readSecureData(key);
//     var headers = {
//       'Authorization':
//        storedValue,
//       'Content-Type': 'application/json'
//     };
//     var request = http.Request(
//         'GET',
//         Uri.parse(
//             'http://ec2-3-7-70-25.ap-south-1.compute.amazonaws.com:8006/user/sendMessage/:${widget.teamId}'));
//     request.body = json.encode({
//       "Email": emailSender.text,
//       "message": message.text,
//     });
//     request.headers.addAll(headers);

//     http.StreamedResponse response = await request.send();

//     if (response.statusCode == 200) {
//       print(await response.stream.bytesToString());
//     } else {
//       print(response.reasonPhrase);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Leader Resources'),
//       ),
//       body: Center(
//         child: Text('This is the LEader assistance Page'),
//       ),
//     );
//   }
// }




import 'dart:convert';

import 'package:brl_task4/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LeaderResource extends StatefulWidget {
  final String teamId;

  LeaderResource(this.teamId);

  @override
  _LeaderResourceState createState() => _LeaderResourceState();
}

class _LeaderResourceState extends State<LeaderResource> {
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  Future<void> sendMessage() async {
   
    String storedValue = await secureStorage.readSecureData(key);

    var headers = {
      'Authorization': storedValue,
      'Content-Type': 'application/json',
    };

   
    var request = http.Request(
      'POST',
      Uri.parse(
          'http://ec2-3-7-70-25.ap-south-1.compute.amazonaws.com:8006/user/sendMessage/${widget.teamId}'),
    );
    request.body = json.encode({
      "Email": emailController.text,
      "message": messageController.text,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
     
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Message sent successfully!'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      
      print(response.reasonPhrase);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to send message. Please try again.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leader Resources'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Recipient Email'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: messageController,
              decoration: InputDecoration(labelText: 'Message'),
              maxLines: 5,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: sendMessage,
              child: Text('Send Message'),
            ),
          ],
        ),
      ),
    );
  }
}
