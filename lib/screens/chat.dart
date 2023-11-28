
// import 'package:flutter/material.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

// class ChatScreen extends StatefulWidget {
//   ChatScreen(String? leaderEmail);

//   @override
//   _ChatScreenState createState() => _ChatScreenState( );
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final TextEditingController _controller = TextEditingController();
//   final List<Map<String, dynamic>> _messages = [];
//   late IO.Socket socket;
//   late String myUsername; // Add this line

//   @override
//   void initState() {
//     super.initState();
//     myUsername = 'test'; // Set your desired username here
//     initSocket();
//   }

//   void initSocket() {
//     // Replace 'http://localhost:4000' with the actual IP address or hostname of your Socket.IO server
//     socket = IO.io('http://3.7.70.25:8006', <String, dynamic>{
//       'transports': ['websocket'],
//       'autoConnect': false,
//     });
//     socket.connect();
//     socket.onConnect((_) {
//       print('Connected: ${socket.id}');
//     });
//     socket.on('message', (data) {
//       setState(() {
//         if (data['username'] != null) {
//         _messages.add({
//           'message': data['message'],
//           'username': data['username'],
//         });
//       }
//        // _messages.add({'message': data['message'], 'username': data['username'] , 'teamId' : data['mohit ke chuche']  });
//       });
//     });
//   }
//   void joinTeam(String teamId) {
//     socket.emit('join', {'teamId': teamId, 'username': myUsername});
//   }

//   void _sendMessage() {
//     if (_controller.text.isNotEmpty) {
//       socket.emit('message', {'message': _controller.text, 'username': myUsername});
//       setState(() {
//         _messages.add({'message': _controller.text, 'username': myUsername});
//       });
//       _controller.clear();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flutter Chat App'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: _messages.length,
//               itemBuilder: (context, index) {
//                 final message = _messages[index]['message'];
//                 final username = _messages[index]['username'];

//                 return ListTile(
//                   title: Container(
//                     padding: EdgeInsets.all(8.0),
//                     decoration: BoxDecoration(
//                       color: username == myUsername ? Colors.blue : Colors.grey,
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     child: Text(
//                       '$username: $message',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _controller,
//                     decoration: InputDecoration(
//                       hintText: 'Enter your message...',
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: _sendMessage,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     socket.disconnect();
//     super.dispose();
//   }
// }


import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreen extends StatefulWidget {
  final String leaderEmail;

  ChatScreen(this.leaderEmail);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  late IO.Socket socket;
  late String myUsername; 

  @override
  void initState() {
    super.initState();
    myUsername = widget.leaderEmail; 
    initSocket();
  }

  void initSocket() {
    // Replace 'http://localhost:4000' with the actual IP address or hostname of your Socket.IO server
    socket = IO.io('http://3.7.70.25:8006', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.connect();
    socket.onConnect((_) {
      print('Connected: ${socket.id}');
    });
    socket.on('message', (data) {
      setState(() {
        if (data['username'] != null) {
          _messages.add({
            'message': data['message'],
            'username': data['username'],
          });
        }
      });
    });
  }

  void joinTeam(String teamId) {
    socket.emit('join', {'teamId': teamId, 'username': myUsername});
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      socket.emit('message', {'message': _controller.text, 'username': myUsername});
      setState(() {
        _messages.add({'message': _controller.text, 'username': myUsername});
      });
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Chat App'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index]['message'];
                final username = _messages[index]['username'];

                return ListTile(
                  title: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: username == myUsername ? Colors.blue : Colors.grey,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      '$username: $message',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Enter your message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
  }
}
