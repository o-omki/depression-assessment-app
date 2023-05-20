import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "package:serenity_space/api/backend_api.dart";
import "package:serenity_space/models/appointment_model.dart";
import "package:serenity_space/screens/appointment/schedule_screen.dart";

// ignore: must_be_immutable
class UpcomingSchedule extends StatelessWidget {
  UpcomingSchedule(this.userAppointmentsUpcoming, {super.key});

  List<Map<String, dynamic>> userAppointmentsUpcoming;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: userAppointmentsUpcoming.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final appointment = userAppointmentsUpcoming[index];
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 233, 235, 233),
                      Color.fromARGB(255, 196, 209, 170),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 2,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "COUNSELLOR",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              appointment["counsellor_name"],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        trailing: CircleAvatar(
                          radius: 35,
                          backgroundImage: NetworkImage(
                            appointment["counsellor_picture"],
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        child: Divider(thickness: 1, height: 20),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "ID: ${appointment["_id"]}",
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_month,
                                size: 25,
                                color: Colors.black54,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                DateFormat("yyyy-MM-dd").format(DateTime.parse(
                                    appointment["appointment_date"])),
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 2.0,
                                      color: appointment["confirmed"]
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                    color: appointment["confirmed"]
                                        ? Colors.green
                                        : Colors.red,
                                    shape: BoxShape.circle),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                appointment["confirmed"]
                                    ? "Confirmed"
                                    : "Not Confirmed",
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              appointment["status"] = "cancelled";
                              AppointmentModel updatedAppointment =
                                  AppointmentModel.fromJson(appointment);
                              updateAppointment(updatedAppointment).then(
                                (_) {
                                  ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Appointment cancelled successfully",
                                        ),
                                      ),
                                    );
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                        return const ScheduleScreen();
                                      }));

                                    
                                },
                              );
                            },
                            child: Container(
                              width: 150,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                // color: Colors.red,
                                // A reddish colour to depict cancellation
                                color: const Color.fromARGB(255, 231, 87, 71),

                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // InkWell(
                          //   onTap: () {
                          //   },
                          //   child: Container(
                          //     width: 150,
                          //     padding: const EdgeInsets.symmetric(vertical: 12),
                          //     decoration: BoxDecoration(
                          //       color: Colors.green.shade500,
                          //       borderRadius: BorderRadius.circular(10),
                          //     ),
                          //     child: const Center(
                          //       child: Text(
                          //         "Reschedule",
                          //         style: TextStyle(
                          //           fontSize: 18,
                          //           fontWeight: FontWeight.w500,
                          //           color: Colors.white,
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
