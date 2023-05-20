import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../api/apis.dart';
import '../../main.dart';
import '../auth/login.dart';
import 'edit_profile.dart';
import 'info_screen.dart';
import 'user_feedback.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: mq.height * .05, horizontal: mq.width * .05),
      child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                width: 140,
                height: 140,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    MongoUser.userDetails["profile_picture"],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                right: 4,
                bottom: 4,
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.amber.shade300,
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EditProfile()));
                    },
                    icon: const Icon(Icons.edit),
                    iconSize: 20,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: mq.height * .015,
          ),
          Text(
            // 'Developer Android',
            MongoUser.userDetails["first_name"],
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: mq.height * .006,
          ),
          Text(
            // 'developer@gmail.com',
            MongoUser.userDetails["email"],
            style: const TextStyle(fontSize: 16, color: Colors.black54),
          ),
          SizedBox(
            height: mq.height * .025,
          ),
          SizedBox(
            width: mq.width * .5,
            height: mq.height * .05,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EditProfile()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber.shade300,
                elevation: 0,
                shape: const StadiumBorder(),
              ),
              child: const Text(
                'Edit Profile',
                style: TextStyle(color: Colors.black87, fontSize: 16),
              ),
            ),
          ),
          SizedBox(
            height: mq.height * .035,
          ),
          const Divider(
            thickness: 1,
          ),
          SizedBox(
            height: mq.height * .015,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => InfoScreen()));
            },
            child: const ListTile(
              title: Text(
                'Information',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UserFeedback()));
            },
            child: const ListTile(
              title: Text(
                'User Feedback',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
          ),
          InkWell(
            onTap: () {
              showAlertDialog(context);
            },
            child: const ListTile(
              title: Text(
                'Logout',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.red,
                ),
              ),
              trailing: Icon(Icons.logout_rounded),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> showAlertDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to proceed?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Proceed',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () async {
                await APIs.fireauth.signOut().then((value) async {
                  await GoogleSignIn().signOut().then((value) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                      ModalRoute.withName('/'),
                    );
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
            ),
          ],
        );
      },
    );
  }
}
