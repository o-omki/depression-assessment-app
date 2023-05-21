import "package:flutter/material.dart";

import "../screens/appointment/doctor_profile_screen.dart";
import "../api/mongo_api_client.dart";

class ShowDoctors extends StatefulWidget {
  const ShowDoctors({
    super.key,
  });

  @override
  State<ShowDoctors> createState() => _ShowDoctorsState();
}

class _ShowDoctorsState extends State<ShowDoctors> {

  List<Map<String, dynamic>> counsellors = [];

  @override
  void initState() {
    super.initState();
    _getAllCounsellors();
  }

  Future<void> _getAllCounsellors() async {
    final result = await MongoDbApiClient.getAllEntities("counsellors_master");
    setState(() {
      counsellors = result;
    });
  }

  String _getAvailablityString(List<dynamic> days) {
    final List<String> shortDays = [];
    for (final day in days) {
      shortDays.add(day.substring(0, 3));
    }
    return shortDays.join(", ");
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: counsellors.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final counsellor = counsellors[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return DoctorProfile(counsellor);
                },
              ),
            );
          },
          child: Card(
            color: Colors.white70,
            child: ListTile(
              leading: CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage(counsellor["profile_picture"],),
              ),
              title: Text(
                counsellor["name"],
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
                    counsellor["specialization"],
                    style: const TextStyle(
                      color: Colors.black45,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _getAvailablityString(counsellor["availability"]["days"]),
                    style: const TextStyle(
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "${counsellor["availability"]["hours"]["start"]} - ${counsellor["availability"]["hours"]["end"]}",
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
