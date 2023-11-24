

import 'package:brl_task4/create&join-Team/create-team.dart';
import 'package:flutter/material.dart';

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
              decoration: InputDecoration(
                labelText: 'Enter email of team member for ${domain.name} team:',
              ),

            ),
            
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
              
              },
              child: Text('Send Invitation Code'),
            ),
          ],
        ),
      ),
    );
  }
}
