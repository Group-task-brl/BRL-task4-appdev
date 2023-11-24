

import 'dart:convert';

import 'package:brl_task4/create&join-Team/create-team.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class TeamDetailsScreen extends StatelessWidget {
  final List<Domain> selectedDomains;
  final String teamname ;
  TeamDetailsScreen( this.teamname ,this.selectedDomains, String teamId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('$teamname'),
      ),
      body: ListView.builder(
        itemCount: selectedDomains.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(selectedDomains[index].name),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InviteMembersScreen(selectedDomains[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class InviteMembersScreen extends StatelessWidget {
  final Domain domain;

  InviteMembersScreen(this.domain);

  TextEditingController emailController = TextEditingController();

  Future<void> _sendInvitation() async {
    var headers = {
      'Content-Type': 'application/json',
    };

    var request = http.Request(
      'POST',
      Uri.parse('http://ec2-3-7-70-25.ap-south-1.compute.amazonaws.com:8006/team/sendTeamcode/6560f7a756e1987406f6b173/${domain.name}'),
    );

    request.body = json.encode({
      "recipients": [emailController.text],
    });

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(await response.stream.bytesToString());
        if (responseData['success'] == true) {
         
          print(responseData['message']);
        } else {
         
          print('Error sending invitation: ${responseData['message']}');
        }
      } else {
      
        print(response.reasonPhrase);
      }
    } catch (error) {
    
      print('Error sending invitation: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invite Members - ${domain.name} Team'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Enter email of team member for ${domain.name} team:',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                
                _sendInvitation();
              },
              child: Text('Send Invitation Code'),
            ),
          ],
        ),
      ),
    );
  }
}
