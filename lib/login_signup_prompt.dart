import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

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
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.7,
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
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 148, 220, 150),
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 80),
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
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 80),
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
