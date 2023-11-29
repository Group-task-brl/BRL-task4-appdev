

import 'dart:convert';
import 'package:brl_task4/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostTextScreen extends StatefulWidget {
  final String teamId;
  PostTextScreen(this.teamId);

  @override
  _PostTextScreenState createState() => _PostTextScreenState();
}

class _PostTextScreenState extends State<PostTextScreen> {
  final TextEditingController _textController = TextEditingController();
  String _responseMessage = '';

  Future<void> postText() async {
    try {
      String storedValue = await secureStorage.readSecureData(key);

      var headers = {
        'Authorization': storedValue,
        'Content-Type': 'application/json',
      };

      var request = http.Request(
          'POST',
          Uri.parse(
              'http://ec2-3-7-70-25.ap-south-1.compute.amazonaws.com:8006/text/addText/${widget.teamId}'));
      request.body = json.encode({"text": _textController.text});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 201) {
        final Map<String, dynamic> responseData =
            json.decode(await response.stream.bytesToString());
        setState(() {
          _responseMessage = responseData['message'];
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to post text. Status code: ${response.statusCode}'),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      print('Error posting text: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('An error occurred while posting text.'),
        backgroundColor: Colors.red,
      ));
    }finally{
      _textController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Text'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Enter your text...',
                
                
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                postText();
                
              },
              child: Text('Post Data'),
            ),
            SizedBox(height: 16.0),
            Text(_responseMessage , style: TextStyle(color: Color.fromARGB(255, 43, 16, 53) , ),),
          ],
        ),
      ),
    );
  }
}



// import 'dart:convert';
// import 'package:brl_task4/screens/login.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class PostTextScreen extends StatefulWidget {
//   @override
//   _PostTextScreenState createState() => _PostTextScreenState();
// }

// class _PostTextScreenState extends State<PostTextScreen> {
//   final TextEditingController _textController = TextEditingController();
//   String _responseMessage = '';

//   Future<void> postText() async {
//     dynamic storedValue = await secureStorage.readSecureData(key);
//     final apiUrl = 'http://ec2-3-7-70-25.ap-south-1.compute.amazonaws.com:8006/text/addText/6565d2164ab31ebc7197d2a4';

//     final headers = <String, dynamic>{
//       'Authorization': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoibW9oaXQiLCJlbWFpbCI6Im1vaGl0MjIxMDIwN0Bha2dlYy5hYy5pbiIsImlzTG9nZ2VkSW4iOiJZZXMiLCJpYXQiOjE3MDA5OTEwNDJ9.jazBt8Kv9aMvF90My2wFUXMIibx8bZtVCzP831c8ImE',
//       'Content-Type': 'application/json',
//     };

//     final requestBody = {'text': _textController.text};
//    // request.headers.addAll(headers);
//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//        headers: headers,
//         body: json.encode(requestBody),
//       );

//       if (response.statusCode == 200) {
//         final Map<String, dynamic> responseData = json.decode(response.body);

//         setState(() {
//           _responseMessage = responseData['message'];
//         });
//       } else {
//         print('Failed to post text. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error posting text: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Post Text'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: _textController,
//               decoration: InputDecoration(
//                 hintText: 'Enter your text...',
//               ),
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () {
//                 postText();
//               },
//               child: Text('Post Text'),
//             ),
//             SizedBox(height: 16.0),
//             Text(_responseMessage),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'dart:convert';
// import 'package:brl_task4/screens/login.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class PostTextScreen extends StatefulWidget {
//   final String teamId;
//   PostTextScreen(this.teamId);

//   @override
//   _PostTextScreenState createState() => _PostTextScreenState();
// }

// class _PostTextScreenState extends State<PostTextScreen> {
//   final TextEditingController _textController = TextEditingController();
//   String _responseMessage = '';



//   Future<void> postText() async {
//     String storedValue = await secureStorage.readSecureData(key);

//     var headers = {
//       'Authorization': storedValue,
//       'Content-Type': 'application/json'
//     };
//     var request = http.Request(
//         'POST',
//         Uri.parse(
//             'http://ec2-3-7-70-25.ap-south-1.compute.amazonaws.com:8006/text/addText/${widget.teamId}'));
//     request.body = json.encode({"text": _textController.text});
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
//         title: Text('Post Text'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: _textController,
//               decoration: InputDecoration(
//                 hintText: 'Enter your text...',
//               ),
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () {
//                 postText();
//               },
//               child: Text('Post Text'),
//             ),
//             SizedBox(height: 16.0),
//             Text(_responseMessage),
//           ],
//         ),
//       ),
//     );
//   }
// }



