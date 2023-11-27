import 'dart:convert';
import 'package:brl_task4/create&join-Team/Domain-team.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../screens/login.dart';

class CreateTeamScreen extends StatefulWidget {
  @override
  _CreateTeamScreenState createState() => _CreateTeamScreenState();
}

class _CreateTeamScreenState extends State<CreateTeamScreen> {
  TextEditingController teamNameController = TextEditingController();

  List<Domain> domains = [
    Domain(id: 1, name: 'Backend'),
    Domain(id: 2, name: 'Frontend'),
    Domain(id: 3, name: 'Machine Learning'),
    Domain(id: 4, name: 'App Development'),
  ];

  List<Domain> selectedDomains = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Create Team'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: teamNameController,
              decoration: const InputDecoration(labelText: 'Team Name'),
            ),
            const SizedBox(height: 16),
            MultiSelectDialogField(
              items: domains
                  .map((domain) => MultiSelectItem<Domain>(domain, domain.name))
                  .toList(),
              title: const Text('Select Domains'),
              buttonText: const Text('Select Domains'),
              onConfirm: (values) {
                selectedDomains = values;
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => TeamDetailsScreen(
                //         selectedDomains, teamNameController.text),
                //   ),
                // );

                createTeam(); // finally chal gya
              },
              child: const Text('Create Team'),
            ),
          ],
        ),
      ),
    );
  }



  Future<void> createTeam() async {

    dynamic storedValue = await secureStorage.readSecureData(key);
    var headers = <String, String>{
      'Authorization' :storedValue,
      'Content-Type': 'application/json'
    };
      print(storedValue);
    var request = http.Request(
      'POST',
      Uri.parse(
          'http://ec2-3-7-70-25.ap-south-1.compute.amazonaws.com:8006/team/createTeam'),
    );

    List<Map<String, dynamic>> domainList = selectedDomains.map((domain) {
      return {
        "name": domain.name,
        "members": [],
      };
    }).toList();

    request.body = json.encode({
      "teamName": teamNameController.text,
      // "leaderEmail": "euclidstellar@gmail.com",
      "domains": domainList,
    });

    request.headers.addAll(headers);

    try {
      print ("hii");
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData =
            jsonDecode(await response.stream.bytesToString());
        final String teamId = responseData['team']['_id'];
        print(teamId);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                TeamDetailsScreen(teamNameController.text, selectedDomains, teamId),
          ),
        );

        _showErrorSnackBar('Team created successfully');
        print(await response.stream.bytesToString());
      } else {
        _showErrorSnackBar(response.reasonPhrase!);
        print(response.reasonPhrase);
      }
    } catch (error) {

      _showErrorSnackBar('Error creating team: $error');
      print('Error creating team: $error');
    }
  }

  void _showErrorSnackBar(String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        duration: Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Dismiss',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}

class Domain {
  final int id;
  final String name;

  Domain({required this.id, required this.name});
}
