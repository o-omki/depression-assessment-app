import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../api/apis.dart';
import '../main.dart';
import 'auth/login.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() {
    return _ProfileScreenState();
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Profile Screen",
            style: TextStyle(fontSize: 40),
          ),
          ElevatedButton.icon(
            onPressed: () async {
              await APIs.fireauth.signOut().then((value) async {
                await GoogleSignIn().signOut().then((value) {
                  // Navigator.pop(context);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const Login()));
                  // await Future.delayed(const Duration(seconds: 3))
                  //     .then((value) {
                  //   Navigator.pushReplacement(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => const LoginScreen()));
                  // });
                });
              });
            },
            icon: const Icon(Icons.logout),
            label: const Text(
              'LOGOUT',
              style: TextStyle(fontSize: 16),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: const StadiumBorder(),
              fixedSize: Size(mq.width * .35, mq.height * .065),
              elevation: 5,
            ),
          ),
        ],
      ),
    );
  }
}
