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
                        return const AlertDialog(
                          title: Text('Mark your Mood for the day'),
                          content: MoodMarker(),
                        );
                      });
                },
                child: const Text('Mark your Mood')),
            const Divider(
              thickness: 2,
            ),
            SizedBox(
              height: mq.height * 0.0125,
            ),
            const Text(
              'My Journal',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: mq.height * 0.0125,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Pick a date:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                TextButton(
                  onPressed: () => _selectDate(context),
                  child: Text(
                    '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ),
              ],
            ),
            SizedBox(height: mq.height * 0.02),
            const SizedBox(
              width: double.infinity,
              child: Text(
                'Write up your day brief:',
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: mq.height * 0.01),
            TextFormField(
              controller: _textEditingController,
              maxLines: 18,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                hintText: 'Today was a good day...',
                hintStyle: const TextStyle(color: Colors.white, fontSize: 18),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade100,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                fillColor: const Color.fromARGB(255, 150, 191, 253),
              ),
            ),
            SizedBox(
              height: mq.height * 0.035,
            ),
            ElevatedButton(onPressed: () {}, child: const Text('Save')),
          ],
        ),
      ),
    );
  }
}
