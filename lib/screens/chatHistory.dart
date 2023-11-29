import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatScreenfetch extends StatefulWidget {
  @override
  _ChatScreenfetchState createState() => _ChatScreenfetchState();
}

class _ChatScreenfetchState extends State<ChatScreenfetch> {
  List<Map<String, dynamic>> _chats = [];

  @override
  void initState() {
    super.initState();
    fetchChats();
  }

  Future<void> fetchChats() async {
    final apiUrl = 'http://ec2-3-7-70-25.ap-south-1.compute.amazonaws.com:8006/chat/getAllChats';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        setState(() {
          _chats = List<Map<String, dynamic>>.from(responseData['chats']);
        });
      } else {
        print('Failed to load chats. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error loading chats: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Chats'),
      ),
      body: _chats.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
            reverse: true,
              itemCount: _chats.length,
              itemBuilder: (context, index) {
                final chat = _chats[index];
                final username = chat['username'];
                final message = chat['message'];

                return ListTile(
                  title: Text('$username: $message'),
                );
              },
            ),
    );
  }
}

