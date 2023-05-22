import 'package:flutter/material.dart';

class MoodMarker extends StatefulWidget {
  const MoodMarker({super.key});

  @override
  State<MoodMarker> createState() => _MoodMarkerState();
}

class _MoodMarkerState extends State<MoodMarker> {
  double _value = 60.0;

  String getEmoji() {
    if (_value <= 20) {
      return '😞';
    } else if (_value <= 40) {
      return '😔';
    } else if (_value <= 60) {
      return '😐';
    } else if (_value <= 80) {
      return '🙂';
    } else {
      return '😄';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              getEmoji(),
              style: const TextStyle(fontSize: 80),
            ),
            const SizedBox(height: 30),
            Slider(
              value: _value,
              min: 0,
              max: 100,
              divisions: 4,
              onChanged: (value) {
                setState(() {
                  _value = value;
                });
              },
            ),
            const SizedBox(
              height: 60,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Submit')),
          ],
        ),
      ),
    );
  }
}
