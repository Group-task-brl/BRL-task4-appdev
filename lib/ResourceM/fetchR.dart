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
  List<dynamic> messages = [];
  bool isLoading = true;

  Future<void> fetchMessages() async {
    try {
      var request = http.Request(
        'GET',
        Uri.parse(
          'http://ec2-3-7-70-25.ap-south-1.compute.amazonaws.com:8006/text/showText/${widget.teamId}',
        ),
      );

      http.Response response = await http.get(request.url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        setState(() {
          isLoading = false;

          if (responseData['data'] is List) {
            messages = responseData['data'];
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
      // appBar: AppBar(
      //   title: Text('Resources'),
      // ),
      body: Column(
        children: [
          Container(
            width: 361,
            height: 146,
            decoration: const BoxDecoration(
              image: DecorationImage(
                alignment: Alignment(1, 0),
                image: AssetImage('lib/assets/amico.png'),
                fit: BoxFit.scaleDown,
              ),
              gradient: LinearGradient(
                begin: Alignment(0.98, -0.21),
                end: Alignment(-0.98, 0.21),
                colors: [Color(0xFF150218), Color(0xFF65386C)],
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0x4C000000),
                  blurRadius: 4,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '\nResource Manager',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16.0),
          isLoading
              ? CircularProgressIndicator()
              : messages.isEmpty
                  ? Text('No messages available.')
                  : Expanded(
                      child: ListView.builder(
                        reverse: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final email = messages[index]['email'];

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '   Email: $email',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: ClampingScrollPhysics(),
                                  itemCount: messages[index]['texts'].length,
                                  itemBuilder: (context, index1) {
                                    final text = messages[index]['texts']
                                        [index1]['text'];
                                    return Card(
                                      elevation: 2.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      color: Color.fromARGB(255, 47, 18, 59),
                                      child: ListTile(
                                        title: Text(
                                          text,
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                Divider(),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
        ],
      ),
    );
  }
}
