import 'package:flutter/material.dart';

// ignore_for_file: prefer_const_constructors

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40.0,
        ),
        CircleAvatar(
          radius: 80.0,
          backgroundImage: AssetImage('lib/assets/prof.png'), 
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          'Shreya Dhangar',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Divider(
      thickness: 1.0,
      color: Colors.grey,
    ),
        _buildProfile('Edit Profile'),
        Divider(
      thickness: 1.0,
      color: Colors.grey,
    ),
        _buildProfile('Security'),
        Divider(
      thickness: 1.0,
      color: Colors.grey,
    ),
        _buildProfile('Suggestion and Feedback'),
        Divider(
      thickness: 1.0,
      color: Colors.grey,
    ),
    _buildProfile('Logout'),
      ],
    );
  }

  Widget _buildProfile(String optionText) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              optionText,
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  
}
