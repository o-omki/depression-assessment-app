import 'package:flutter/material.dart';

import '../../api/apis.dart';
import '../../main.dart';
import '../../widget/chart_graph.dart';
import 'questionnaire.dart';

import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final String phoneNumber = '+919999666555';
  void _launchPhone() async {
    final Uri url = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: mq.width * .04,
              top: mq.height * .03,
              bottom: mq.width * .05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hello,',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black54,
                  letterSpacing: 1,
                ),
              ),
              Text(
                APIs.user.displayName == ""
                    ? "Mate!"
                    : APIs.user.displayName!.split(" ")[0],
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: mq.height * 0.01,
        ),
        Padding(
          padding: EdgeInsets.only(left: mq.width * 0.3),
          child: const Text(
            'Your weekly mood~',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.only(left: 8, bottom: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 4,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ChartGraph(APIs.user.uid),
          ),
        ),
        SizedBox(
          height: mq.height * .03,
        ),
        const Divider(
          thickness: 2,
        ),
        SizedBox(
          height: mq.height * .05,
        ),
        Card(
          elevation: 4,
          color: Colors.green.shade100,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Show up for the Questionnaire',
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: mq.height * .02,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Questionnaire()));
                    },
                    icon: const Icon(
                      Icons.run_circle_rounded,
                      size: 30,
                    ),
                    label: SizedBox(
                      width: mq.width * .2,
                      child: const Text(
                        'Start',
                        style: TextStyle(fontSize: 21),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: mq.height * .05,
        ),
        GestureDetector(
          onTap: _launchPhone,
          child: Card(
            elevation: 4,
            color: Colors.blue.shade300,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Emergency Helpline',
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: mq.height * .02,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/customer-care.png',
                        height: mq.height * 0.05,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: mq.width * 0.05,
                      ),
                      const Text(
                        '+91 9999 666 555',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: mq.height * .02,
                  ),
                  const Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      'Vandrevala Foundation',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: mq.height * .05,
        ),
      ],
    );
  }
}
