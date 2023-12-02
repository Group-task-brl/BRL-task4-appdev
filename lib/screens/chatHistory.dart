
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatScreenfetch extends StatefulWidget {
  const ChatScreenfetch({super.key});

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
    const apiUrl = 'http://ec2-3-7-70-25.ap-south-1.compute.amazonaws.com:8006/chat/getAllChats';

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
        backgroundColor: const Color.fromARGB(255, 49, 12, 56),
        foregroundColor: Colors.white,
        elevation: 12,
        shadowColor: Colors.black,
        title: const Text('Discussion History'),
      ),
      body: _chats.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
           //reverse: true,
            itemCount: _chats.length,
            itemBuilder: (context, index) {
              final chat = _chats[index];
              final username = chat['username'];
              final message = chat['message'];

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Card(
                  color: const Color.fromARGB(255, 46, 17, 55),
                  shadowColor: Colors.black,
                 // surfaceTintColor: Colors.white,
                 
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ListTile(
                    title: Text(
                      '$username:',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                        color: Color.fromARGB(255, 254, 254, 254),
                      ),
                    ),
                    subtitle: Text(
                      message,
                      style: const TextStyle(
                        fontSize: 18.0,
                        color:Color.fromARGB(255, 220, 228, 73),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
    );
  }
}

