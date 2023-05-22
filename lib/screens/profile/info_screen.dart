import 'package:flutter/material.dart';

import '../../main.dart';

class InfoScreen extends StatelessWidget {
  InfoScreen({super.key});

  final List<Map<String, dynamic>> creators = [
    {
      'name': 'D Omkar Murty',
      'desc': 'B. Tech CSE (AIML)',
      'image': 'assets/images/switzerland.png'
    },
    {
      'name': 'Biplab Tarafder',
      'desc': 'B. Tech CSE (CS)',
      'image': 'assets/images/switzerland.png'
    },
    {
      'name': 'Ashish Mandal',
      'desc': 'B. Tech CSE (CS)',
      'image': 'assets/images/switzerland.png'
    },
    {
      'name': 'Sarmin Ahmed',
      'desc': 'B. Tech CSE (AIML)',
      'image': 'assets/images/switzerland.png'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black54,
            ),
          ),
          title: const Text('Information'),
          centerTitle: true,
          elevation: 0,
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 16, top: 16),
                child: Text(
                  'About Creators',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: mq.height * .25,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      margin: const EdgeInsets.all(16),
                      color: Colors.grey.shade100,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: Padding(
                        padding: EdgeInsets.all(mq.height * .015),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  AssetImage(creators[index]['image']),
                            ),
                            SizedBox(height: mq.height * .015),
                            Text(
                              // 'Creator $index',
                              creators[index]['name'],
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              // 'Description of Creator $index',
                              creators[index]['desc'],
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.black54),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Divider(
                thickness: 1.5,
              ),
              SizedBox(
                height: mq.height * .03,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  'Description of the App',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: mq.height * .02, horizontal: mq.width * .05),
                child: RichText(
                  text: const TextSpan(
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        letterSpacing: .5,
                      ),
                      children: [
                        TextSpan(
                          text: 'Serenity Space',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        TextSpan(
                          text:
                              ', an app to assess depression levels, schedule appointments with counsellors, and maintain a journal. Built using Flutter, compatible with iOS and Android. Integrates with Firebase and MongoDB for authentication and database management.',
                        ),
                      ]),
                ),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: mq.height * 0.02),
                child: const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Version 1.0.0',
                    style: TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
