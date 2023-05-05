import 'package:flutter/material.dart';

import '../../main.dart';
import '../../widget/chart_graph.dart';
import 'questionnaire.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
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
            children: const [
              Text(
                'Hello,',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black54,
                  letterSpacing: 1,
                ),
              ),
              Text(
                'Developer',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: mq.height * .02,
        ),
        Padding(
          padding: EdgeInsets.only(left: mq.width * .2),
          child: const Text(
            'Your Week Stat is here',
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
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: ChartGraph(),
          ),
        ),
        SizedBox(
          height: mq.height * .03,
        ),
        Divider(
          thickness: 2,
        ),
        SizedBox(
          height: mq.height * .02,
        ),
        Card(
          elevation: 4,
          color: Colors.green.shade100,
          margin: EdgeInsets.symmetric(horizontal: 10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
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
                        icon: Icon(
                          Icons.run_circle_rounded,
                          size: 30,
                        ),
                        label: SizedBox(
                          width: mq.width * .2,
                          child: Text(
                            'Start',
                            style: TextStyle(fontSize: 21),
                            textAlign: TextAlign.center,
                          ),
                        ))),
              ],
            ),
          ),
        ),
        SizedBox(
          height: mq.height * .05,
        ),
        Container(
          height: 300,
          color: Colors.red,
        ),
      ],
    );
  }
}
