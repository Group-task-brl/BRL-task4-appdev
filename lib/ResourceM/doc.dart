import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DocumentationPage extends StatefulWidget {
  @override
  _DocumentationPageState createState() => _DocumentationPageState();
}

class _DocumentationPageState extends State<DocumentationPage> {
  TextEditingController updateController = TextEditingController();
  List<UpdateItem> updates = [];

  @override
  void initState() {
    super.initState();
    loadUpdates();
  }

  void loadUpdates() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String existingUpdates = prefs.getString('updates') ?? '';
    setState(() {
      updates = UpdateItem.fromStoredString(existingUpdates);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Documentation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: updateController,
              maxLines: 5,
              decoration: InputDecoration(labelText: 'Write your update...'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                saveUpdate(updateController.text);
              },
              child: Text('Save Update'),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                reverse: true, 
                itemCount: updates.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(updates[index].text),
                    subtitle: Text(updates[index].formattedDateTime),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void saveUpdate(String update) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UpdateItem newUpdate = UpdateItem(text: update, dateTime: DateTime.now());
    setState(() {
      updates.insert(0, newUpdate);
    });
    prefs.setString('updates', UpdateItem.toStoredString(updates));
    updateController.clear();
  }
}

class UpdateItem {
  String text;
  DateTime dateTime;

  UpdateItem({required this.text, required this.dateTime});


  static String toStoredString(List<UpdateItem> updates) {
    return updates.map((update) => '${update.text}~${update.dateTime.toIso8601String()}').join('\n');
  }

  
  static List<UpdateItem> fromStoredString(String storedString) {
    List<String> updateStrings = storedString.split('\n');
    return updateStrings
        .where((element) => element.isNotEmpty)
        .map((updateString) {
          List<String> parts = updateString.split('~');
          return UpdateItem(text: parts[0], dateTime: DateTime.parse(parts[1]));
        })
        .toList();
  }


  String get formattedDateTime {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
  }
}
