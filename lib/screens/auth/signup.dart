import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:serenity_space/main.dart';

import '../../api/apis.dart';
import '../../helper/dialogs.dart';
import '../bottom_nav_bar.dart';

import 'login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  var name = "";
  var email = "";
  var password = "";
  var confPassword = "";

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confPasswordController = TextEditingController();

  var _isPassObscured = true;
  var _isConfPassObscured = true;

  bool validateEmail(String email) {
    String pattern = r'^[a-zA-Z0-9.!]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your Password';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters long';
      // } else if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)[A-Za-z\d]+$')
    } else if (!RegExp(
            r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&#])[A-Za-z\d@$!%*?&#]{8,}$')
        .hasMatch(value)) {
      return 'Password must contain [0-9] [a-z] [A-Z]\nwith special character';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your Password';
    } else if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  String firstName = "";
  String middleName = "";
  String lastName = "";

  nameSplitter() {
    List<String> nameSplit = name.split(" ");
    if (nameSplit.length == 1) {
      firstName = nameSplit[0];
      middleName = "";
      lastName = "";
    } else if (nameSplit.length == 2) {
      firstName = nameSplit[0];
      middleName = "";
      lastName = nameSplit[1];
    } else {
      firstName = nameSplit[0];
      middleName = nameSplit[1];
      lastName = nameSplit[2];
    }
  }

  Future<void> _createUser() async {
    nameSplitter();
    try {
      final UserCredential credential =
          await APIs.fireauth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await APIs.createUserWithEmailPass(firstName, middleName, lastName);
      log("Document created successfully\n");
      log("Credential: $credential");
      Dialogs.showSnackbar(context, 'Registered Successfully');
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const BottomNavBar()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Dialogs.showSnackbar(context, 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Dialogs.showSnackbar(
            context, 'The account already exists for that email.');
      }
    } catch (e) {
      log('$e');
    }
  }

  @override
  void dispose() {
    // clean up the controller when widget is disposed
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confPasswordController.dispose();
    super.dispose();
  }

  _handleGoogleLoginBtnClick() {
    Dialogs.showProgressBar(context);
    _signInWithGoogle().then((user) async {
      Navigator.pop(context);
      if (user != null) {
        log('\nUser: ${user.user}');
        log('\nUserAdditionalInfo: ${user.additionalUserInfo}');
        log('\nUserCredential: ${user.credential}');

        if ((await APIs.userExists())) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const BottomNavBar()));
        } else {
          await APIs.createUserWithGoogle().then((value) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const BottomNavBar()));
          });
        }
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (_) => const BottomNavBar()));
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
              top: mq.height * .08,
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
                child: Column(
                  children: [
                    Expanded(
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
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.person),
                                    hintText: 'Name',
                                  ),
                                  controller: nameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your Name';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.email),
                                    hintText: 'Email',
                                  ),
                                  controller: emailController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your Email';
                                    } else if (!validateEmail(value)) {
                                      return 'Please enter valid Email';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: TextFormField(
                                  obscureText: _isPassObscured,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.lock),
                                    hintText: 'Password',
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _isPassObscured = !_isPassObscured;
                                        });
                                      },
                                      icon: _isPassObscured
                                          ? const Icon(Icons.visibility)
                                          : const Icon(Icons.visibility_off),
                                    ),
                                  ),
                                  controller: passwordController,
                                  validator: (value) =>
                                      _validatePassword(value),
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: TextFormField(
                                  obscureText: _isConfPassObscured,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.lock),
                                    hintText: 'Confirm Password',
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _isConfPassObscured =
                                              !_isConfPassObscured;
                                        });
                                      },
                                      icon: _isConfPassObscured
                                          ? const Icon(Icons.visibility)
                                          : const Icon(Icons.visibility_off),
                                    ),
                                  ),
                                  controller: confPasswordController,
                                  validator: (value) =>
                                      _validateConfirmPassword(value),
                                ),
                              ),
                              SizedBox(
                                height: mq.height * 0.02,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  // validate returns true if the form is valid, otherwise false
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      name = nameController.text.trim();
                                      email = emailController.text.trim();
                                      password = passwordController.text.trim();
                                      confPassword =
                                          confPasswordController.text.trim();
                                    });
                                    _createUser();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize:
                                      Size.fromHeight(mq.height * 0.06),
                                  shape: const StadiumBorder(),
                                ),
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              SizedBox(
                                height: mq.height * 0.03,
                              ),
                              const Spacer(),
                              Column(
                                children: [
                                  ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.indigo.shade200,
                                      shape: const StadiumBorder(),
                                      minimumSize:
                                          Size.fromHeight(mq.height * 0.06),
                                    ),
                                    onPressed: () {
                                      _handleGoogleLoginBtnClick();
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
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
