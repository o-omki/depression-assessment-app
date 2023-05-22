import 'package:flutter/material.dart';

import '../../main.dart';

class UserFeedback extends StatefulWidget {
  const UserFeedback({super.key});

  @override
  State<UserFeedback> createState() => _UserFeedbackState();
}

class _UserFeedbackState extends State<UserFeedback> {
  int _rating = 0;
  final TextEditingController _commentController = TextEditingController();

  void _submitFeedback() {
    // TODO: Implement feedback submission logic
    print(
        "Submitted feedback: rating=$_rating, comment=${_commentController.text}");
  }

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
          title: const Text('Feedback'),
          centerTitle: true,
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.all(mq.height * .02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Rate our app",
                style: TextStyle(fontSize: 20.0),
              ),
              SizedBox(height: mq.height * .02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _rating = 1;
                      });
                    },
                    icon: Icon(
                      _rating >= 1 ? Icons.star : Icons.star_border,
                      size: 40.0,
                      color: Colors.amber,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _rating = 2;
                      });
                    },
                    icon: Icon(
                      _rating >= 2 ? Icons.star : Icons.star_border,
                      size: 40.0,
                      color: Colors.amber,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _rating = 3;
                      });
                    },
                    icon: Icon(
                      _rating >= 3 ? Icons.star : Icons.star_border,
                      size: 40.0,
                      color: Colors.amber,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _rating = 4;
                      });
                    },
                    icon: Icon(
                      _rating >= 4 ? Icons.star : Icons.star_border,
                      size: 40.0,
                      color: Colors.amber,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _rating = 5;
                      });
                    },
                    icon: Icon(
                      _rating >= 5 ? Icons.star : Icons.star_border,
                      size: 40.0,
                      color: Colors.amber,
                    ),
                  ),
                ],
              ),
              SizedBox(height: mq.height * .04),
              const Text(
                "Tell us more",
                style: TextStyle(fontSize: 20.0),
              ),
              SizedBox(height: mq.height * .02),
              TextField(
                controller: _commentController,
                decoration: const InputDecoration(
                  hintText: "Enter your feedback",
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
              ),
              SizedBox(height: mq.height * 0.06),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    if (_rating > 0) {
                      _submitFeedback();
                      Navigator.pop(context);
                    } else {
                      null;
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber.shade300,
                    foregroundColor: Colors.black87,
                  ),
                  child: const Text(
                    "Submit",
                    style: TextStyle(fontSize: 18),
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
