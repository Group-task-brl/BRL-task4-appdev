import 'dart:convert';

import 'package:brl_task4/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TaskContainer extends StatefulWidget {
  @override
  State<TaskContainer> createState() => _TaskContainerState();
}

class _TaskContainerState extends State<TaskContainer> {
  Future<void>? _futureData;
  List<dynamic>? compTasks;
  String? task;

  void initState() {
    super.initState();
    _futureData = showTeamAPI();
  }

  Future<void> showTeamAPI() async {
    dynamic storedValue = await secureStorage.readSecureData(key);

    final String apiUrl =
        'http://ec2-3-7-70-25.ap-south-1.compute.amazonaws.com:8006/team/incompleteTasks';

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Authorization': storedValue,

      },
    );

    if (response.statusCode == 200) {
      // print('hiii');
      setState(
        () {
          compTasks = jsonDecode(response.body)['incompleteTasks'];
          print(compTasks);
          // compTasks = jsonDecode(response.body)['incompleteTasks'];
          // task = compTasks?.map((task) => task['description']);
        },
      );
    } else {
      print(' ${response.statusCode}');
      print('Error Message: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'lib/assets/login.png',
              width: 100,
              height: 100,
            ),
            SizedBox(height: 16.0),
            Text(
              'Tasks',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            FutureBuilder<void>(
              future: _futureData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                      child: CircularProgressIndicator(
                      color:Colors.purple,
                      ),
                  );
                } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                 } else {
                    if(compTasks==null){
                      return Text("No tasks");
                    }
                  return Container(
                    height: 300,
                    child: ListView.builder(
                     itemCount:compTasks!.length,
                      itemBuilder: (context,index){
                          return ListTile(
                            title: Container(
                              width: MediaQuery.of(context).size.width/(4/3),
                              height: MediaQuery.of(context).size.height/10,
                              color: Colors.grey.shade50,
                              child: Row(
                                  children: [
                                    Container(height: MediaQuery.of(context).size.height/15,width: 2,color: Colors.purple,),
                                    SizedBox(width: 20,),
                                    Text(compTasks![index]['description'],style: TextStyle(color: Colors.black),),
                                  ],
                            ),
                          ));
                     },),
                  );
                  }
              },
            ),
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: compTasks?.length ?? 0,
            //     itemBuilder: (context, index) {
            //       return TaskListItem(
            //         title: compTasks?[index]['description'] ?? '',
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class TaskListItem extends StatelessWidget {
  final String title;

  TaskListItem({required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      // Task items
    );
  }
}
