import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../screens/appointment_screen.dart';
import '../screens/home_screen.dart';
import '../screens/journal_screen.dart';
import '../screens/profile_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final _item = const <Widget>[
    Icon(Icons.home, size: 30),
    Icon(Icons.calendar_month_rounded, size: 30),
    Icon(Icons.book_rounded, size: 30),
    Icon(Icons.person, size: 30),
  ];

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          height: 55,
          color: Colors.green.shade400,
          backgroundColor: Colors.white,
          animationDuration: const Duration(milliseconds: 400),
          items: _item,
          onTap: (index) {
            setState(() {
              _index = index;
            });
          },
        ),
        body: Container(
          color: Colors.white,
          height: double.infinity,
          width: double.infinity,
          child: getScreen(index: _index),
        ),
      ),
    );
  }
}

getScreen({required int index}) {
  switch (index) {
    case 0:
      return HomeScreen();
    case 1:
      return AppointmentScreen();
    case 2:
      return JournalScreen();
    case 3:
      return ProfileScreen();
  }
}
