import 'package:flutter/material.dart';
import 'package:brl_task4/screens/teamDetail.dart';

// ignore_for_file: prefer_const_constructors

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Color.fromARGB(255, 209, 180, 213),
        backgroundColor:  Color.fromARGB(255, 141, 26, 156),
        selectedIndex: currentPageIndex,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.pie_chart),
            label: 'Progress',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month),
            label: 'Tasks',
          ),
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
      body: [
        Container(
          alignment: Alignment.center,
          child: t_detail(),
        ),
        Container(
            color: Colors.green,
            alignment: Alignment.center,
            child: t_detail() ),
        Container(
          color: Colors.blue,
          alignment: Alignment.center,
          child: t_detail(),
        ),
        Container(
          color: Colors.blue,
          alignment: Alignment.center,
          child: t_detail(),
        ),
        Container(
          color: Colors.blue,
          alignment: Alignment.center,
          child: t_detail(),
        ),
      ][currentPageIndex],
    );
  }
}
