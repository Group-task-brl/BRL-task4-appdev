
import 'package:brl_task4/create&join-Team/Domain-team.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TeamDetailsScreen(selectedDomains),
                  ),
                );
                createTeam();
                
              },
              child: const Text('Create Team'),
            ),
          ],
        ),
      ),
    );
  }

  void createTeam() {
   
  }
}

class Domain {
  final int id;
  final String name;

  Domain({required this.id, required this.name});
}
