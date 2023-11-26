import 'package:flutter/material.dart';
// ignore_for_file: prefer_const_constructors

class HomeNav extends StatefulWidget {
  @override
  _HomeNavState createState() => _HomeNavState();
}

class _HomeNavState extends State<HomeNav> {
  int _selectedIndex = 0;
  List _pages = [
    Center(child: Text('Page 1')),
    Center(child: Text('Page 2')),
  ];

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: _pages[_selectedIndex],
    //   bottomNavigationBar: BottomNavigationBar(
    //     items: [
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.group),
    //         label: 'Teams',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.list),
    //         label: 'To-Do List',
    //       ),
    //     ],
    //     currentIndex: _selectedIndex,
    //     onTap: (index) {
    //       setState(() {
    //         _selectedIndex = index;
    //       });
    //     },
    //   ),
    // );
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.group),
            onPressed: () {
              _onNavItemTapped(0);
            },
          ),
          Text('Teams',),
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              _onNavItemTapped(1);
            },
          ),
          Text('To-Do List'),
        ],
      ),
      body: _pages[_selectedIndex],
    );
  }

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
