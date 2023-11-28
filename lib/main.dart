// app dev starts here
// only push here in dev branch 
// do not merge in main branch

import 'package:brl_task4/screens/MarkTaskDone.dart';
import 'package:brl_task4/screens/addTask.dart';
import 'package:brl_task4/screens/dashboard.dart';
import 'package:brl_task4/screens/join_team.dart';
import 'package:brl_task4/screens/signup.dart';
import 'package:brl_task4/screens/login.dart';
import 'package:brl_task4/screens/teamDetail.dart';
import 'package:brl_task4/utils/Routes.dart';
import'package:flutter/material.dart';
import 'package:brl_task4/home_page/todo.dart';
import 'create&join-Team/create-team.dart';
import 'home_page/bottomnavbar.dart';
import 'home_page/home_page_home.dart';
import 'home_page/teams.dart';
import 'home_page/tasks.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context)  {
    dynamic storedValue = secureStorage.readSecureData(key);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: BottomNavBar(),

        initialRoute: '/',
        routes: {
          '/':(context)=>SignUp(),

          // '/': (context) => (storedValue==null)?SignUp():BottomNavBar(),
        MyRoutes.SignUpRoutes: (context) => SignUp(),
        MyRoutes.LoginRoutes: (context) => Login(),
        MyRoutes.dashbMemRoutes: (context) => dashb_mem(),
        MyRoutes.jointeamRoutes: (context) => join_team(),
        MyRoutes.CreateTeamScreen: (context) => CreateTeamScreen(),
        MyRoutes.BottomNavBar:(context) => BottomNavBar(),
          MyRoutes.DoneTask:(context) => doneTask(),
        MyRoutes.Todo:(context) => TodoList(),
          // MyRoutes.AddTask:(context) => addTask(),

          }
        );
  }
}
