import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

import '../main.dart';
import 'auth/login.dart';
import 'auth/signup.dart';

class PromptMenu extends StatelessWidget {
  const PromptMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/screen_bg.jpg"),
            opacity: 0.45,
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7),
            child: GlassmorphicContainer(
              width: mq.width * 1,
              height: mq.height * 0.7,
              borderRadius: 20,
              blur: 7,
              border: 1,
              linearGradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.25),
                  Colors.grey.withOpacity(0.2),
                ],
              ),
              borderGradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.4),
                  Colors.grey.withOpacity(0.25),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 42,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "Hey There!",
                      style: TextStyle(
                          fontFamily: "PTMono",
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20, top: 7),
                    child: Text(
                      "Welcome",
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    height: 145,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Login(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: const Color(0XFF33CC33),
                      backgroundColor: const Color.fromARGB(255, 235, 252, 239),
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 80),
                      side: const BorderSide(
                        color: Color(0XFF33CC33),
                        width: 3,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUp(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0XFF33CC33),
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 80),
                        side: const BorderSide(
                          color: Colors.white,
                          width: 2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
