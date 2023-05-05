import 'package:flutter/material.dart';

class Questionnaire extends StatefulWidget {
  const Questionnaire({super.key});

  @override
  State<Questionnaire> createState() => _QuestionnaireState();
}

class _QuestionnaireState extends State<Questionnaire> {
  int _currentQuestionIndex = 0;
  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'Sadness',
      'options': [
        '1. I do not feel sad',
        '2. I feel sad much of the time',
        '3. I am sad all the time',
        "4. I am so sad or unhappy that I can't stand it"
      ],
    },
    {
      'question': 'Pessimism',
      'options': [
        '1. I am not discouraged about my future',
        '2. I feel more discouraged about my future than I used to',
        '3. I do not expect things to work out for me',
        '4. I feel my future is hopeless and will only get worse'
      ],
    },
    {
      'question': 'Past Failure',
      'options': [
        '1. I do not feel like a failure',
        '2. I have failed more than I should have',
        '3. As I look back, I see a lot of failures',
        '4. I feel I am a total failure as a person'
      ],
    },
    {
      'question': 'Loss of Pleasure',
      'options': [
        '1. I get as much pleasure as I ever did from the things I enjoy',
        "2. I don't enjoy things as much as I used to.",
        '3. I get very little pleasure from the things I used to enjoy',
        "4. I can't get any pleasure from the things I used to enjoy"
      ],
    },
    {
      'question': 'Guilty Feelings',
      'options': [
        "1. I don't feel particularly guilty",
        '2. I feel guilty over many things I have done or should have done',
        '3. I feel quite guilty most of the time',
        '4. I feel guilty all of the time'
      ],
    },
    {
      'question': 'Punishment Feelings',
      'options': [
        "1. I don't feel I am being punished",
        '2. I feel I may be punished',
        '3. I expect to be punished',
        '4. I feel I am being punished'
      ],
    },
    {
      'question': 'Self-Dislike',
      'options': [
        '1. I feel the same about myself as ever',
        '2. I have lost confidence in myself',
        '3. I am disappointed in myself',
        '4. I dislike myself'
      ],
    },
    {
      'question': 'Self-Criticalness',
      'options': [
        "1. I don't criticise or blame myself more than usual",
        '2. I am more critical of myself than I used to be',
        '3. I criticise myself for all of my faults',
        '4. I blame myself for everything bad that happens'
      ],
    },
    {
      'question': 'Suicidal Thoughts or Wishes',
      'options': [
        "1. I don't have any thougts of killing myself",
        '2. I have thougts of killing myself, but I would not carry them out',
        '3. I would like to kill myself',
        '4. I would kill myself if I had the chance'
      ],
    },
    {
      'question': 'Crying',
      'options': [
        "1. I don't cry anymore than I used to",
        '2. I cry more than I used to',
        '3. I cry over every little thing',
        "4. I feel like crying, but I can't"
      ],
    },
    {
      'question': 'Agitation',
      'options': [
        '1. I am no more restless or wound up than usual',
        '2. I feel more restless or wound up than usual',
        "3. I am so restless or agitated, it's hard to stay still",
        '4. I am so restless or agitated that I have to keep moving or doing something'
      ],
    },
    {
      'question': 'Loss of Interest',
      'options': [
        '1. I have not lost interest in other people or activities',
        '2. I am less interested in other people or things than before',
        '3. I have lost most of my interest in other people or things',
        "4. It's hard to get interested in anything"
      ],
    },
    {
      'question': 'Indecisiveness',
      'options': [
        '1. I make decisions about as well as ever',
        '2. I find it more difficult to make decisions than usual.',
        '3. I have much greater difficulty in making decisions than I used to',
        '4. I have trouble making any decisions'
      ],
    },
    {
      'question': 'Worthlessness',
      'options': [
        '1. I do not feel I am worthless',
        "2. I don't consider myself as worthwhile and useful as I used to",
        '3. I feel more worthless as compared to others',
        '4. I feel utterly worthless'
      ],
    },
    {
      'question': 'Loss of Energy',
      'options': [
        '1. I have as much energy as ever',
        '2. I have less energy than I used to have',
        "3. I don't have enough energy to do very much",
        "4. I don't have enough energy to do anything"
      ],
    },
    {
      'question': 'Changes in Sleeping Pattern',
      'options': [
        '1. I have not experienced any change in my sleeping',
        '2.1. I sleep somewhat more than usual',
        '2.2. I sleep somewhat less than usual',
        '3.1. I sleep a lot more than usual',
        '3.2. I sleep a lot less than usual',
        '4.1. I sleep most of the day',
        "4.2. I wake up 1-2 hours early and can't get back to work"
      ],
    },
    {
      'question': 'Irritability',
      'options': [
        '1. I am not more irritable than usual',
        '2. I am more irritable than usual',
        '3. I am much more irritable than usual',
        '4. I am irritable all the time'
      ],
    },
    {
      'question': 'Changes in Appetite',
      'options': [
        '1. I have not experienced any change in my appetite',
        '2.1. My appetite is somewhat less than usual',
        '2.2. My appetite is somewhat greater than usual',
        '3.1. My appetite is much less than before',
        '3.2. My appetite is more greater than before',
        '4.1. I have no appetite at all.',
        '4.2. I crave food all the time'
      ],
    },
    {
      'question': 'Concentration Difficulty',
      'options': [
        '1. I can concentrate as well as ever',
        "2. I can't concentrate as well as usual",
        "3. It's hard to keep my mind on anything for very long",
        "4. I find I can't concentrate on anything"
      ],
    },
    {
      'question': 'Tiredness or Fatigue',
      'options': [
        '1. I am no more tired or fatigued than usual',
        '2. I get more tired or fatigued more easily than usual',
        '3. I am too tired or fatigued to do a lot of things I used to do',
        '4. I am too tired or fatigued to do most of the things I used to do'
      ],
    },
    {
      'question': 'Loss of Interest in Sex',
      'options': [
        '1. I have not noticed any recent change in my interest in sex',
        '2. I am less interested in sex than I used to be',
        '3. I am much less interested in sex now',
        '4. I have lost interest in sex completely'
      ],
    },
  ];

  List<String> _selectedAnswers = List.filled(21, '');

  int score = 0;

  void _selectAnswer(String option) {
    score += int.parse(option[0]);
    setState(() {
      _selectedAnswers[_currentQuestionIndex] = option;
    });
  }

  void _previousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
      });
    }
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < 20) {
      setState(() {
        _currentQuestionIndex++;
      });
    }
  }

  Widget _buildQuestion(int index) {
    Map<String, dynamic> question = _questions[index];
    List<String> options = question['options'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        Text(
          '${question['question']}',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        ...options.map((option) => RadioListTile(
              title: Text(option),
              value: option,
              groupValue: _selectedAnswers[index],
              onChanged: (value) => _selectAnswer(value!),
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded),
            color: Colors.black54,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('Questionnaire'),
          centerTitle: true,
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: _buildQuestion(_currentQuestionIndex)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: _previousQuestion,
                    child: Text('Prev'),
                  ),
                  ElevatedButton(
                    onPressed: _nextQuestion,
                    child: Text('Next'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
