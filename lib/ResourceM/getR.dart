import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GEtR extends StatefulWidget {
  @override
  _GEtRState createState() => _GEtRState();
}

class _GEtRState extends State<GEtR> {
  List<dynamic> data = [];
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      setState(() {
        data = json.decode(response.body);
      });
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      throw Exception('Failed to load data');
    }
  }

  Future<void> postData(String title, String body) async {
    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      body: jsonEncode({'title': title, 'body': body, 'userId': 1}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      // If the server returns a 201 Created response, fetch the updated data
      fetchData();
    } else {
      // If the server did not return a 201 Created response, throw an exception.
      throw Exception('Failed to post data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Data Fetching/Posting Example'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: bodyController,
              decoration: InputDecoration(labelText: 'Body'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Example of posting data
              postData(titleController.text, bodyController.text);
            },
            child: Text('Post Data'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(data[index]['title']),
                  subtitle: Text(data[index]['body']),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
