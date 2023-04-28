import 'package:flutter/material.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() {
    return _JournalScreenState();
  }
}

class _JournalScreenState extends State<JournalScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Journal Screen",
        style: TextStyle(fontSize: 40),
      ),
    );
  }
}
