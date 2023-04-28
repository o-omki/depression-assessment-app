import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class APIs {
  // for firebase auhtentication
  static FirebaseAuth fireauth = FirebaseAuth.instance;

  // to return current user details
  static User get user => fireauth.currentUser!;

  // to return current userinfo details
  static UserInfo get userInfo => user.providerData[0];

  // for accessing cloud firestore database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  // to check if user exists or not
  static Future<bool> userExists() async {
    return (await firestore.collection('users').doc(user.uid).get()).exists;
  }

  // for creating a new user
  // static Future<void> createUser() async {
  //   final time = DateTime.now().millisecondsSinceEpoch.toString();
  //   final chatuser = ChatUser(
  //       image: userInfo.photoURL.toString(),
  //       about: 'Hey There! I am using In Chat',
  //       name: user.displayName.toString(),
  //       createdAt: time,
  //       isOnline: false,
  //       id: user.uid,
  //       lastActive: time,
  //       email: user.email.toString(),
  //       pushToken: "");
  //   return await firestore
  //       .collection('users')
  //       .doc(user.uid)
  //       .set(chatuser.toJson());
  // }
}
