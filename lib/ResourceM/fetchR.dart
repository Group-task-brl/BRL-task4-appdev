import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ShowTextScreen extends StatefulWidget {
  final String teamId;
  ShowTextScreen(this.teamId);

  @override
  _ShowTextScreenState createState() => _ShowTextScreenState();
}

class _ShowTextScreenState extends State<ShowTextScreen> {
  List<Map<String, dynamic>> messages = [];

  // Future<void> fetchMessages() async {
  //   try {
  //     var request = http.Request(
  //         'GET',
  //         Uri.parse(
  //             'http://ec2-3-7-70-25.ap-south-1.compute.amazonaws.com:8006/text/showText/${widget.teamId}'));

  //     http.Response response = await http.get(request.url);

  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> responseData =
  //           json.decode(response.body);

  //       setState(() {
  //         messages = (responseData['data'] as List<dynamic>).cast<Map<String, dynamic>>();
  //       });
  //     } else {
  //       print('Failed to fetch messages. Status code: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error fetching messages: $e');
  //   }
  // }

  Future<void> fetchMessages() async {
  try {
    var request = http.Request(
        'GET',
        Uri.parse(
            'http://ec2-3-7-70-25.ap-south-1.compute.amazonaws.com:8006/text/showText/6565d2164ab31ebc7197d2a4'));

    http.Response response = await http.get(request.url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      setState(() {
        // Check if 'data' exists and is a list
        if (responseData['data'] is List) {
          messages = (responseData['data'] as List<dynamic>)
              .cast<Map<String, dynamic>>();
        } else {
          print('Invalid data structure');
        }
      });
    } else {
      print('Failed to fetch messages. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching messages: $e');
  }
}


  @override
  void initState() {
    super.initState();
    fetchMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resources'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Resources: ${messages.length}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final email = messages[index]['email'];
                
                  final texts = messages[index]['texts'] as List<Map<String, dynamic>>;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email: $email',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8.0),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: texts.length,
                        itemBuilder: (context, index) {
                          final text = texts[index]['text'];
                          return ListTile(
                            title: Text(text),
                          );
                        },
                      ),
                      Divider(),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
