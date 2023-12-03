import 'dart:convert';
import 'package:brl_task4/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApplyLeave extends StatefulWidget {
  final String teamid;

  ApplyLeave({required this.teamid});

  @override
  _ApplyLeaveState createState() => _ApplyLeaveState();
}

class _ApplyLeaveState extends State<ApplyLeave> {
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<String?> applyLeaveAPI(
      String startDate, String endDate, String reason) async {

    String StoreLeaveId;
    dynamic storedValue = await secureStorage.readSecureData(key);
    final String apiUrl =
        'http://ec2-3-7-70-25.ap-south-1.compute.amazonaws.com:8006/leave/applyLeave/${widget.teamid}';

    var body = jsonEncode({
      "startDate": startDate,
      "endDate": endDate,
      "reason": reason,
    });

    var headers = <String, String>{
      'Content-Type': 'application/json',
      'Authorization': storedValue,
      'teamId' : widget.teamid,
    };

    try {
      var response =
          await http.post(Uri.parse(apiUrl), headers: headers, body: body);

      if (response.statusCode == 200) {
        print('Leave applied successfully');
        StoreLeaveId = jsonDecode(response.body);
        print(jsonDecode(response.body));
        LeaveID(StoreLeaveId);
        return null;
      } else {
        print('Error: ${response.statusCode}');
        print(jsonDecode(response.body));
        return jsonDecode(response.body)['error'];
      }
    } catch (e) {
      print('Error: $e');
      return 'An error occurred';
    }
  }

  Future<void> LeaveID(String StoreLeaveID) async {    dynamic storedValue = await secureStorage.readSecureData(key);
    final String apiUrl =
        'http://ec2-3-7-70-25.ap-south-1.compute.amazonaws.com:8006/leave/leaveResult/$StoreLeaveID';

    var headers = <String, String>{
      'Content-Type': 'application/json',
      'Authorization': storedValue,
      'leaveId' : StoreLeaveID,
    };
     http.post(Uri.parse(apiUrl), headers: headers);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Opacity(
            opacity: 0.5,
            child: Image.asset(
              "lib/assets/back.png",
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Apply for Leave",
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 10),
                    const Text(
                      "Provide the start date, end date, and reason for leave",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: startDateController,
                            decoration: InputDecoration(
                              labelText: 'Start Date: 02-12-2023',
                              prefixIcon: Icon(Icons.calendar_today),
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 15),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the start date';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: endDateController,
                            decoration: InputDecoration(
                              labelText: 'End Date: 23-12-2023',
                              prefixIcon: Icon(Icons.calendar_today),
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 15),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the end date';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: reasonController,
                            decoration: InputDecoration(
                              labelText: 'Reason for Leave',
                              prefixIcon: Icon(Icons.description),
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 15),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the reason for leave';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () => _applyLeave(context),
                            child: Text('Apply for Leave'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _applyLeave(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      String startDate = startDateController.text;
      String endDate = endDateController.text;
      String reason = reasonController.text;

      String? result = await applyLeaveAPI(startDate, endDate, reason);

      if (result == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Leave applied successfully!'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $result'),
          ),
        );
      }
    }
  }
}
