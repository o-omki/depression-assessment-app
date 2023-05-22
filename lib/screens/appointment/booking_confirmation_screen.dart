import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "package:serenity_space/api/backend_api.dart";

import "../../models/appointment_model.dart";

// ignore: must_be_immutable
class BookingConfirmationScreen extends StatefulWidget {
  BookingConfirmationScreen(
    this.counsellor,
    this.appointmentDetails, {
    super.key,
  });

  late final Map<String, dynamic> counsellor;
  late final AppointmentModel appointmentDetails;
  late final Map<String, dynamic> appointmentDetailsMap;

  @override
  State<BookingConfirmationScreen> createState() =>
      _BookingConfirmationScreenState();
}

class _BookingConfirmationScreenState extends State<BookingConfirmationScreen> {
  @override
  void initState() {
    super.initState();
    widget.appointmentDetailsMap = widget.appointmentDetails.toJson();
  }

  // Map<String, dynamic> _getMongoDBInsertionDocument() {
  //   Map<String, dynamic> document = widget.appointmentDetails.toJson();
  //   document.remove("_id");
  //   return document;
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Material(
        child: SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new_rounded),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(
                          width: 60,
                        ),
                        const Text(
                          "Booking Confirmation",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width * 0.95,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 233, 235, 233),
                            Color.fromARGB(255, 219, 238, 182),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.09,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.green.shade300,
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        DateTime.parse(widget.appointmentDetails
                                                .appointmentDate)
                                            .day
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        DateFormat("MMMM").format(
                                            DateTime.parse(widget
                                                .appointmentDetails
                                                .appointmentDate)),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  DateFormat("EEEE").format(DateTime.parse(
                                      widget
                                          .appointmentDetails.appointmentDate)),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 80),
                                IconButton(
                                  icon: const Icon(
                                    Icons.edit_calendar_rounded,
                                    color: Colors.black54,
                                    size: 40,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                            const Text(
                              "What would you like to talk about?",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.1,
                              width: MediaQuery.of(context).size.width * 0.8,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white,
                              ),
                              child: TextFormField(
                                maxLines: 4,
                                initialValue:
                                    widget.appointmentDetails.description,
                                decoration: const InputDecoration(
                                  hintText: "Share your problems here...",
                                  hintStyle: TextStyle(
                                    color: Colors.black87,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(10.0),
                                ),
                                onChanged: (value) {
                                  widget.appointmentDetails.description = value;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Card(
                      margin: const EdgeInsets.all(10.0),
                      color: Colors.white70,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(10.0),
                        leading: CircleAvatar(
                          radius: 35,
                          backgroundImage: NetworkImage(
                            widget.counsellor["profile_picture"],
                          ),
                        ),
                        title: Text(
                          widget.counsellor["name"],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Text(
                              widget.counsellor["specialization"],
                              style: const TextStyle(
                                color: Colors.black45,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              (widget.counsellor["availability"]["days"])
                                  .join(", "),
                              style: const TextStyle(
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "${widget.counsellor["availability"]["hours"]["start"]}",
                            ),
                            const SizedBox(height: 5),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            bottomNavigationBar: InkWell(
              onTap: () {
                // final document = _getMongoDBInsertionDocument();
                createAppointment(widget.appointmentDetails);
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Appointment Booked"),
                      content: const Text(
                        "Your appointment has been booked successfully. Head over to the Bookings tab to view your appointments.",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("OK"),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.08,
                padding: const EdgeInsets.symmetric(vertical: 18),
                decoration: BoxDecoration(
                  color: Colors.green.shade700,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    "Confirm Appointment",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
