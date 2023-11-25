// app dev starts here
// only push here in dev branch 
// do not merge in main branch

import 'package:brl_task4/screens/dashboard.dart';
import 'package:brl_task4/screens/join_team.dart';
import 'package:brl_task4/screens/signup.dart';
import 'package:brl_task4/screens/login.dart';
import 'package:brl_task4/screens/teamDetail.dart';
import 'package:brl_task4/utils/Routes.dart';
import'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          // '/':(context)=>dashb_mem(),
        '/': (context) =>SignUp(),
        MyRoutes.SignUpRoutes: (context) => SignUp(),
        MyRoutes.LoginRoutes: (context) => Login(),
        MyRoutes.dashbMemRoutes: (context) => dashb_mem(),
        MyRoutes.jointeamRoutes: (context) => join_team(),
        MyRoutes.tdetailRoutes: (context) => t_detail(),
          }
        );
  }
}
