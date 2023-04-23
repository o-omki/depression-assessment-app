import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:flutter/material.dart";

import "package:serenity_space/screens/splash_screen.dart";

Future main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Serenity Space",
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const SplashScreen(),
    );
  }
}
