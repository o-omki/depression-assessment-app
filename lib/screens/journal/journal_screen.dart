import 'package:flutter/material.dart';

import '../../main.dart';
import 'mood_marker.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() {
    return _JournalScreenState();
  }
}

class _JournalScreenState extends State<JournalScreen> {
  late DateTime _selectedDate;
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _textEditingController.text =
            ''; // Clear the text field when the date is changed
      });
    }
  }

  bool _markedMood = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Mark your Mood for the day'),
                          content: MoodMarker(),
                        );
                      });
                },
                child: Text('Mark your Mood')),
            Divider(
              thickness: 2,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Pick a date:'),
                TextButton(
                  onPressed: () => _selectDate(context),
                  child: Text(
                    '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            const SizedBox(
              width: double.infinity,
              child: Text(
                'Write up your day brief:',
              ),
            ),
            const SizedBox(height: 8.0),
            TextFormField(
              controller: _textEditingController,
              maxLines: 20,
              decoration: const InputDecoration(
                hintText: 'Today was a good day...',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(onPressed: () {}, child: Text('Save')),
          ],
        ),
      ),
    );
  }
}
