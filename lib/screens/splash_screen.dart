import "dart:async";

import "package:flutter/material.dart";
import "package:flutter/services.dart";

import "package:serenity_space/main.dart";
import "package:serenity_space/screens/login_signup_prompt.dart";

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
            statusBarColor: Colors.green,
            systemNavigationBarColor: Colors.white),
      );

      // exit from full-screen
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const PromptMenu()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: mq.width,
        height: mq.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0XFF33CC33), Colors.black],
            begin: AlignmentDirectional(1, -1),
            end: AlignmentDirectional(-1, 1),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/icons/mental_health.png",
              width: 140,
              height: 140,
              fit: BoxFit.fitHeight,
            ),
            const Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
              child: Text(
                "Serenity Space",
                style: TextStyle(
                  fontFamily: "Kalam",
                  color: Colors.white,
                  fontSize: 60,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
              child: Text(
                "you matter!",
                style: TextStyle(
                  fontFamily: "Kalam",
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
