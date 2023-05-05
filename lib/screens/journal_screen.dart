import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../providers/journal_provider.dart";
import "../mood_line_graph_screen.dart"

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() {
    return _JournalScreenState();
  }
}

class _JournalScreenState extends State<JournalScreen> {
  late JournalProvider _journalProvider;

  @override
  void initState() {
    super.initState();
    _journalProvider = JournalProvider();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Journal"),
      ),
      body: Column(
        children: [
          MoodLineGraphScreen(),
          const SizedBox(height: 10.0),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, "/mood_selection_screen");
            },
            child: const Text("How's your day?")
          )
        ]
      )
    );
  }
}

