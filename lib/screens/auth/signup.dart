import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:serenity_space/main.dart';

import '../../api/apis.dart';
import '../../helper/dialogs.dart';
import '../../helper/bottom_nav_bar.dart';

import 'login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  var email = "";
  var password = "";

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var _isObscured = true;

  _handleLoginBtnClick() {
    Dialogs.showProgressBar(context);
    _signInWithGoogle().then((user) async {
      Navigator.pop(context);
      if (user != null) {
        log('\nUser: ${user.user}');
        log('\nUserAdditionalInfo: ${user.additionalUserInfo}');
        log('\nUserCredential: ${user.credential}');

        // if ((await APIs.userExists())) {
        //   Navigator.pushReplacement(
        //       context, MaterialPageRoute(builder: (_) => const HomeScreen()));
        // } else {
        //   await APIs.createUser().then((value) {
        //     Navigator.pushReplacement(
        //         context, MaterialPageRoute(builder: (_) => const HomeScreen()));
        //   });
        // }
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const BottomNavBar()));
      }
    });
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try {
      await InternetAddress.lookup('google.com');
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await APIs.fireauth.signInWithCredential(credential);
    } catch (e) {
      log('\n_signInWithGoogle: $e');
      Dialogs.showSnackbar(context, 'Oops! Something Went Wrong');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              color: const Color(0XFF33CC33),
            ),
            Positioned(
              top: mq.height * .15,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 20,
                        offset: const Offset(0, -2),
                      )
                    ]),
                height: mq.height,
                width: mq.width,
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30),
                    child: ListView(
                      children: [
                        const Text(
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 35, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.email),
                              hintText: 'Email',
                              hintStyle: const TextStyle(
                                fontSize: 20,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color(0XFF33CC33), width: 2.0),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 2.0),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 212, 57, 46),
                                    width: 2.0),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 212, 57, 46),
                                    width: 2.0),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              errorStyle: const TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 212, 57, 46),
                              ),
                            ),
                            controller: emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Email';
                              } else if (!value.contains('@')) {
                                return 'Please enter valid Email';
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                            obscureText: _isObscured,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock),
                              hintText: 'Password',
                              hintStyle: const TextStyle(
                                fontSize: 20,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color(0XFF33CC33), width: 2.0),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 2.0),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 212, 57, 46),
                                    width: 2.0),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 212, 57, 46),
                                    width: 2.0),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              errorStyle: const TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 212, 57, 46),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isObscured = !_isObscured;
                                  });
                                },
                                icon: _isObscured
                                    ? const Icon(Icons.visibility)
                                    : const Icon(Icons.visibility_off),
                              ),
                            ),
                            controller: passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Password';
                              }
                              return null;
                            },
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () => {},
                                child: const Text(
                                  'Forgot Password',
                                  style: TextStyle(
                                      fontSize: 14, letterSpacing: 1.5),
                                )),
                            SizedBox(
                              height: mq.height * 0.017,
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size.fromHeight(mq.height * 0.06),
                                shape: const StadiumBorder(),
                              ),
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: mq.height * 0.06,
                        ),
                        SizedBox(height: mq.height * 0.13),
                        Column(
                          children: [
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.indigo.shade200,
                                shape: const StadiumBorder(),
                                minimumSize: Size.fromHeight(mq.height * 0.06),
                              ),
                              onPressed: () {
                                _handleLoginBtnClick();
                              },
                              icon: Image.asset(
                                'assets/images/google.png',
                                height: mq.height * .04,
                              ),
                              label: RichText(
                                text: const TextSpan(
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 17),
                                  children: [
                                    TextSpan(text: 'Login with '),
                                    TextSpan(
                                        text: 'Google',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500)),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: mq.height * 0.015,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Already have an Account? "),
                                TextButton(
                                    onPressed: () => {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const Login(),
                                            ),
                                          )
                                        },
                                    child: const Text('Login'))
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
