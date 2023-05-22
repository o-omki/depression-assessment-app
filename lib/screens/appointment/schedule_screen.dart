import "package:flutter/material.dart";
import "package:serenity_space/api/backend_api.dart";

import "../../api/apis.dart";
import "../../widget/upcoming_schedule.dart";
import "../../widget/completed_schedule.dart";
import "../../widget/cancelled_schedule.dart";

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  int _buttonIndex = 0;
  bool _isInitialized = false;

  List<StatelessWidget> scheduleWidgets = [];

  List<StatelessWidget> _initialiseScheduleWidgets() {
    List<StatelessWidget> scheduleWidgets = [];
    scheduleWidgets.add(UpcomingSchedule(userAppointmentsUpcoming));
    scheduleWidgets.add(CompletedSchedule(userAppointmentsCompleted));
    scheduleWidgets.add(CancelledSchedule(userAppointmentsCancelled));
    return scheduleWidgets;
  }

  List<Map<String, dynamic>> userAppointmentsCompleted = [];
  List<Map<String, dynamic>> userAppointmentsCancelled = [];
  List<Map<String, dynamic>> userAppointmentsUpcoming = [];

  @override
  void initState() {
    super.initState();
    _getUserAppointments().then(
      (_) {
        setState(
          () {
            scheduleWidgets.addAll(_initialiseScheduleWidgets());
            _isInitialized = true;
          },
        );
      },
    );
  }

  Future<void> _getUserAppointments() async {
    final result = await fetchUserAppointments(APIs.user.uid);
    setState(() {
      userAppointmentsCompleted = result["completed"];
      userAppointmentsCancelled = result["cancelled"];
      userAppointmentsUpcoming.addAll(result["upcoming"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Material(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black54,
            ),
          ),
          centerTitle: true,
          title: const Text(
            "Bookings",
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
                              ? Colors.green.shade500
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Upcoming",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: _buttonIndex == 0
                                ? Colors.white
                                : Colors.black38,
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
                              ? Colors.green.shade500
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Completed",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: _buttonIndex == 1
                                ? Colors.white
                                : Colors.black38,
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
                              ? Colors.green.shade500
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Cancelled",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: _buttonIndex == 2
                                ? Colors.white
                                : Colors.black38,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              scheduleWidgets[_buttonIndex],
            ],
          ),
        ),
      ),
    );
  }
}
