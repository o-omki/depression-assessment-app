import "package:flutter/material.dart";
import "package:intl/intl.dart";

// ignore: must_be_immutable
class CompletedSchedule extends StatelessWidget {
  CompletedSchedule(this.userAppointmentsCompleted, {super.key});

  List<Map<String, dynamic>> userAppointmentsCompleted;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: userAppointmentsCompleted.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final appointment = userAppointmentsCompleted[index];
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 233, 235, 233),
                      Color.fromARGB(255, 196, 209, 170),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
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
                          radius: 25,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_month,
                                size: 30,
                                color: Colors.black54,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                DateFormat("yyyy-MM-dd").format(
                                    DateTime.parse(appointment["appointment_date"])),
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              // TODO: Review Button working.
                            },
                            child: Container(
                              width: 130,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Text(
                                  "Write a review",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
