import 'package:flutter/material.dart';

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
        _buildProfile('Edit Profile', Icons.arrow_forward_ios_outlined),
        Divider(
          thickness: 1.0,
          color: Colors.grey,
        ),
        _buildProfile('Security', Icons.arrow_forward_ios_outlined),
        Divider(
          thickness: 1.0,
          color: Colors.grey,
        ),
        _buildProfile('Suggestion and Feedback', Icons.arrow_forward_ios_outlined),
        Divider(
          thickness: 1.0,
          color: Colors.grey,
        ),
        _buildProfile('Logout', Icons.logout),
      ],
    );
  }

  Widget _buildProfile(String optionText, IconData icon) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              optionText,
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            Icon(
              icon,
              size: 20.0,
              color: Color.fromARGB(255, 101, 56, 108),
            ),
          ],
        ),
      ),
    );
  }
}
