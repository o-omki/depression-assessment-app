import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'appointment/appointment_home_screen.dart';
import 'home/home_screen.dart';
import 'journal/journal_screen.dart';
import 'profile/profile_screen.dart';

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
        backgroundColor: Colors.white,
        bottomNavigationBar: CurvedNavigationBar(
          height: 60,
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
        body: getScreen(index: _index),
      ),
    );
  }
}

getScreen({required int index}) {
  switch (index) {
    case 0:
      return HomeScreen();
    case 1:
      return AppointmentHomeScreen();
    case 2:
      return JournalScreen();
    case 3:
      return ProfileScreen();
  }
}
