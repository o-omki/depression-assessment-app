import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../main.dart';
import 'auth/login.dart';
import 'auth/signup.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();

  var email = "";

  final emailController = TextEditingController();

  bool validateEmail(String email) {
    String pattern = r'^[a-zA-Z0-9.!]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }

  resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Password Reset Link has been sent. Please check your mail',
          style: TextStyle(fontSize: 18),
        ),
        backgroundColor: Colors.blue,
        behavior: SnackBarBehavior.floating,
      ));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'No User found for this Email',
            style: TextStyle(fontSize: 18),
          ),
          backgroundColor: Colors.orange,
          behavior: SnackBarBehavior.floating,
        ));
      }
    }
  }

  @override
  // Clean up the controller when the widget is disposed
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Reset Password'),
          ),
          body: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: const Text(
                  'Reset Link will be sent to your registered Email ID',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 30),
                      child: ListView(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
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
                          SizedBox(
                            height: mq.height * 0.03,
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 60),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        setState(() {
                                          email = emailController.text;
                                        });
                                        resetPassword();
                                      }
                                    },
                                    child: const Text(
                                      'Send Reset Link',
                                      style: TextStyle(fontSize: 18),
                                    )),
                                TextButton(
                                    onPressed: () => {
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              PageRouteBuilder(
                                                  pageBuilder:
                                                      (context, a, b) =>
                                                          const Login(),
                                                  transitionDuration:
                                                      const Duration(
                                                          seconds: 0)),
                                              (route) => false)
                                        },
                                    child: const Text(
                                      'Login',
                                      style: TextStyle(fontSize: 14),
                                    ))
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Don't have an Account? "),
                                TextButton(
                                    onPressed: () => {
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              PageRouteBuilder(
                                                  pageBuilder:
                                                      (context, a, b) =>
                                                          const SignUp(),
                                                  transitionDuration:
                                                      const Duration(
                                                          seconds: 0)),
                                              (route) => false)
                                        },
                                    child: const Text('Sign Up'))
                              ],
                            ),
                          )
                        ],
                      ),
                    )),
              )
            ],
          )),
    );
  }
}
