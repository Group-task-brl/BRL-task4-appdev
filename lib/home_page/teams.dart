import 'package:flutter/material.dart';
import '../Utils/Routes.dart';

class TeamPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, MyRoutes.CreateTeamScreen);
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'lib/assets/create_team.png',
                    width: 50,
                    height: 50,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Create Team',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, MyRoutes.CreateTeamScreen);
                      },
                      icon: Icon(Icons.add))
                ],
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, MyRoutes.jointeamRoutes);
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'lib/assets/join_team.png',
                    width: 50,
                    height: 50,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Join Team',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, MyRoutes.jointeamRoutes);
                    },
                    icon: Icon(Icons.add),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
