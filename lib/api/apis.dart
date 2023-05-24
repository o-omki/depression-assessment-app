import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'backend_api.dart';
import 'mongo_api_client.dart';

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
    log("I am here");
    // return (await firestore.collection('users').doc(user.uid).get()).exists;
    return await checkUserExists(user.uid);
  }

  // for creating a new user for Google Sign in
  static Future<void> createUserWithGoogle() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    // final chatuser = ChatUser(
    //     image: userInfo.photoURL.toString(),
    //     name: user.displayName.toString(),
    //     createdAt: time,
    //     isOnline: false,
    //     id: user.uid,
    //     lastActive: time,
    //     email: user.email.toString(),
    //     pushToken: "");

    Map<String, dynamic> mongoDoc = {
      "_id": user.uid,
      "email": user.email.toString(),
      "first_name": user.displayName,
      "middle_name": null,
      "last_name": null,
      "age": null,
      "sex": null,
      "address": {
        "street": null,
        "city": null,
        "state": null,
        "zip": null,
      },
      "profile_picture": userInfo.photoURL,
      "programme": null,
      "year": 1,
      "emergency_number": null,
      "created_at": time,
      "last_active_at": time,
    };

    await MongoDbApiClient.addEntity("users_master", mongoDoc);

    // return await firestore
    //     .collection('users')
    //     .doc(user.uid)
    //     .set(chatuser.toJson());
  }

  // for creating a new user for email-password log in
  static Future<void> createUserWithEmailPass(
      firstName, middleName, lastName) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    Map<String, dynamic> mongoDoc = {
      "_id": user.uid,
      "email": user.email.toString(),
      "first_name": firstName,
      "middle_name": middleName,
      "last_name": lastName,
      "age": null,
      "sex": null,
      "address": {
        "street": null,
        "city": null,
        "state": null,
        "zip": null,
      },
      "profile_picture":
          "https://firebasestorage.googleapis.com/v0/b/serenity-space-app-dd637.appspot.com/o/default%2Fprofile.png?alt=media&token=fdb09e4c-a98b-4332-af73-fce9336b5917",
      "programme": null,
      "year": 1,
      "emergency_number": null,
      "created_at": time,
      "last_active_at": time,
    };

    await MongoDbApiClient.addEntity("users_master", mongoDoc);
  }

  // update profile picture of the user
  // static Future<void> updateProfilePic(File file) async {
  //   // taking out image file extension
  //   final ext = file.path.split('.').last;
  //   log('Image extension: $ext');

  //   // storing ref with path
  //   final ref = fstorage.ref().child('profle_pics/${user.uid}.$ext');

  //   // upload image
  //   await ref
  //       .putFile(file, SettableMetadata(contentType: 'image/$ext'))
  //       .then((p0) {
  //     log('Data Transferred: ${p0.bytesTransferred / 1000} kB');
  //   });

  //   // TODO: update image url in MongoDB
  //   // update image url in MongoDB
  // }
}

// to get user details from the collection
class MongoUser {
  static Map<String, dynamic> userDetails = {};
  static Future<void> fetchUser() async {
    userDetails =
        await MongoDbApiClient.getEntityById("users_master", APIs.user.uid);
  }
}
