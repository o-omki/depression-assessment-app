import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:serenity_space/screens/splash_screen.dart";

import "firebase_options.dart";

//global object to access device screen size
late Size mq;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //start app in full screen
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  // for setting orientation to portrait only mode
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) {
    _initializeFirebase();
    runApp(const MyApp());
  });
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
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: const TextStyle(
            fontSize: 20,
          ),
          errorStyle: const TextStyle(
            fontSize: 15,
            color: Color.fromARGB(255, 212, 57, 46),
          ),
          filled: true,
          fillColor: Colors.grey.shade200,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade100, width: 2.0),
            borderRadius: BorderRadius.circular(30.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0XFF33CC33), width: 2.0),
            borderRadius: BorderRadius.circular(30.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Color.fromARGB(255, 212, 57, 46), width: 2.0),
            borderRadius: BorderRadius.circular(30.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Color.fromARGB(255, 212, 57, 46), width: 2.0),
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

_initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
