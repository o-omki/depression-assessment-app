import 'package:flutter/material.dart';
import 'package:serenity_space/login_signup_prompt.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Serenity Space',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: PromptMenu(),
    );
  }
}
