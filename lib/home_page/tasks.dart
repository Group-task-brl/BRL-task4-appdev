import 'package:flutter/material.dart';

class TaskContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black, // Adjust the color as needed
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
            Expanded(
              child: ListView(
                children: [
                  TaskListItem(title: 'Task 1'),
                  TaskListItem(title: 'Task 2'),
                  TaskListItem(title: 'Task 3'),
                ],
              ),
            ),
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
      //task items
    );
  }
}