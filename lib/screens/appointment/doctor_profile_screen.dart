import "dart:developer";

import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import "package:mongo_dart/mongo_dart.dart" as mongo_package;

import "../../models/appointment_model.dart";
import "./booking_confirmation_screen.dart";
import "../../api/apis.dart";
import "../../api/mongo_api_client.dart";

import 'package:url_launcher/url_launcher.dart';

class DoctorProfile extends StatefulWidget {
  late Map<String, dynamic> counsellor;

  DoctorProfile(this.counsellor, {super.key});

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  late String phoneNumber;
  void _launchPhone() async {
    final Uri url = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  final List images = [
    "doctor1.jpeg",
    "doctor2.jpeg",
    "doctor3.jpg",
    "doctor4.avif",
  ];

  late DateTime appointmentDate;
  late List<dynamic> eligibleDays;

  DateTime findClosestMatchingDay(List<dynamic> eligibleDays) {
    // Find the closest future date that matches one of the eligible days.

    DateTime currentDate = DateTime.now();
    DateTime closestDate = currentDate;

    while (!eligibleDays.contains(DateFormat('EEEE').format(closestDate))) {
      closestDate = closestDate.add(const Duration(days: 1));
    }

    return closestDate;
  }

  Future<Map<String, dynamic>> _getUserDetails(
      mongo_package.ObjectId userId) async {
    final user = await MongoDbApiClient.getEntityById("users_master", userId);
    return user;
  }

  void showDateSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 500,
          child: ListView.builder(
            itemCount: 7,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Card(
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context, index);
                  },
                  child: SizedBox(
                    height: 50,
                    width: 100,
                    child: Text("Date $index"),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Future<void> selectAppointmentDate(BuildContext context) async {
    // Calender Pop-up to choose one of the eligible days
    DateTime currentDate = DateTime.now();

    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: appointmentDate,
      firstDate: DateTime.now(),
      lastDate: currentDate.add(const Duration(days: 365)),
      selectableDayPredicate: (DateTime date) {
        return eligibleDays.contains(DateFormat('EEEE').format(date));
      },
    );

    if (selectedDate != null && selectedDate != appointmentDate) {
      setState(() {
        appointmentDate = selectedDate;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    phoneNumber = widget.counsellor['contact']['phone'];
    eligibleDays = widget.counsellor["availability"]["days"];
    appointmentDate = findClosestMatchingDay(eligibleDays);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 40,
            elevation: 0,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 25,
              ),
            ),
            actions: [
              InkWell(
                onTap: () {},
                child: const Icon(
                  Icons.more_vert,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ],
          ),
          backgroundColor: Colors.green,
          body: SingleChildScrollView(
            child: Column(
              children: [
                // const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Stack(
                    alignment: AlignmentDirectional.topStart,
                    children: [
                      Positioned(
                        left: MediaQuery.of(context).size.width * 0.01,
                        top: MediaQuery.of(context).size.height * 0.04,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              widget.counsellor["profile_picture"]),
                          radius: 45,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 5,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 120),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 15),
                              Text(
                                widget.counsellor["name"],
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                widget.counsellor["specialization"],
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(3),
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF9F97E2),
                                      shape: BoxShape.circle,
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        _launchPhone();
                                      },
                                      icon: const Icon(
                                        Icons.call,
                                        color: Colors.white,
                                      ),
                                      iconSize: 30.0,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Container(
                                    padding: const EdgeInsets.all(3),
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF9F97E2),
                                      shape: BoxShape.circle,
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        // TODO: implement CHAT
                                      },
                                      icon: const Icon(
                                        CupertinoIcons.chat_bubble_text_fill,
                                        color: Colors.white,
                                      ),
                                      iconSize: 30.0,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: MediaQuery.of(context).size.height / 1.5,
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 15,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Text(
                        "About Doctor",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.counsellor["about"],
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text(
                            "Testimonials",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Icon(Icons.star, color: Colors.amber),
                          Text(
                            "${widget.counsellor["ratings"].fold(0.0, (a, b) => a + b["rating"]) / widget.counsellor["ratings"].length}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "(${widget.counsellor["ratings"].length})",
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF7165D6)),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              "See all",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF7165D6),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 160,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.counsellor["ratings"].length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 9,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width / 1.4,
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: const CircleAvatar(
                                        radius: 25,
                                        backgroundImage: AssetImage(
                                            "assets/images/switzerland.png"),
                                      ),
                                      title: const Text(
                                        "Alex",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: const Text("1 day ago"),
                                      trailing: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: const [
                                          Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          Text(
                                            "4.5",
                                            style: TextStyle(
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Text(
                                        "Many thanks to this wonderful professional doctor.",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Location",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      ListTile(
                        leading: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.green.shade100,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.location_on,
                            size: 30,
                          ),
                        ),
                        title: Text(
                          "${widget.counsellor["contact"]["address"]["city"]}, ${widget.counsellor["contact"]["address"]["state"]}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                            widget.counsellor["contact"]["address"]["street"]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.all(15),
            height: 160,
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat("yyyy-MM-dd").format(appointmentDate),
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          selectAppointmentDate(context);
                        },
                        child: const Text("Change Date")),
                  ],
                ),
                const SizedBox(height: 15),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          AppointmentEntry newAppointment = AppointmentEntry(
                            id: '',
                            userId: APIs.user.uid,
                            userName: APIs.user.displayName ?? "",
                            userPicture: APIs.user.photoURL ??
                                "assets/images/switzerland.png",
                            counsellorId: widget.counsellor["_id"].toString(),
                            counsellorName: widget.counsellor["name"],
                            counsellorPicture:
                                widget.counsellor["profile_picture"],
                            confirmed: false,
                            status: 'upcoming',
                            appointmentDate: appointmentDate,
                            description: '',
                            createdAt: DateTime.now(),
                            updatedAt: DateTime.now(),
                          );

                          return BookingConfirmationScreen(
                            widget.counsellor,
                            newAppointment,
                          );
                        },
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    decoration: BoxDecoration(
                      color: Colors.green.shade700,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        "Book Appointment",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
