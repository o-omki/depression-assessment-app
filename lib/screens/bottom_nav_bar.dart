import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../api/apis.dart';
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

  bool _userFetched = false;

  @override
  void initState() {
    MongoUser.fetchUser().then((value) {
      setState(() {
        _userFetched = true;
      });
      super.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return _userFetched
        ? SafeArea(
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
          )
        : const Scaffold(
            body: LoaderOverlay(
              useDefaultLoading: false,
              child: Center(
                child: SpinKitWave(
                  color: Colors.red,
                  size: 70.0,
                ),
              ),
            ),
          );
  }
}

getScreen({required int index}) {
  switch (index) {
    case 0:
      return const HomeScreen();
    case 1:
      return const AppointmentHomeScreen();
    case 2:
      return const JournalScreen();
    case 3:
      return const ProfileScreen();
  }
}
