import "dart:io";

import "package:flutter/material.dart";

import "../../api/apis.dart";
import "../../widget/upcoming_schedule.dart";

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  int _buttonIndex = 0;

  final _scheduleWidgets = [
    const UpcomingSchedule(),
    Container(),
    Container(),
  ];

  @override
  void initState() {
    super.initState();
    print(APIs.user.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          title: const Text(
            "Schedule",
            style: TextStyle(
              color: Colors.black,
              fontSize: 32,
              fontWeight: FontWeight.w500,
            ),
          ),
          
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F6FA),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          _buttonIndex = 0;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 25),
                        decoration: BoxDecoration(
                          color: _buttonIndex == 0
                              ? const Color(0xFF7165D6)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Upcoming",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color:
                                _buttonIndex == 0 ? Colors.white : Colors.black38,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _buttonIndex = 1;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 25),
                        decoration: BoxDecoration(
                          color: _buttonIndex == 1
                              ? const Color(0xFF7165D6)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Completed",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color:
                                _buttonIndex == 1 ? Colors.white : Colors.black38,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _buttonIndex = 2;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 25),
                        decoration: BoxDecoration(
                          color: _buttonIndex == 2
                              ? const Color(0xFF7165D6)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Cancelled",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color:
                                _buttonIndex == 2 ? Colors.white : Colors.black38,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              _scheduleWidgets[_buttonIndex],
            ],
          ),
        ),
      ),
    );
  }
}
