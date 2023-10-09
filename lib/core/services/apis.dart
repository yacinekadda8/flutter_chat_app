import 'dart:developer';

import 'package:chat_app/data/models/user_model.dart';
import 'package:chat_app/env.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class APIs {
  // for authentication
  static FirebaseAuth auth = FirebaseAuth.instance;
  // for FirebaseFirestore database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  //  for storing current user information
  static late UserModel currentUser;
  // current user
  static User get user => auth.currentUser!;
  //cheek if user existe
  static Future<bool> userExists() async {
    return (await firestore.collection('users').doc(user.uid).get()).exists;
  }

  //get current User Info
  static Future<void> getCurrentUserInfo() async {
    await firestore.collection('users').doc(user.uid).get().then((user) async {
      if (user.exists) {
        currentUser = UserModel.fromJson(user.data()!);
        log("My Data: ${user.data()}");
      } else {
        await createUserInGoogleUp().then((value) => getCurrentUserInfo());
      }
    });
  }

  // create a new user
  static Future<void> createUserInSignUp({required String name}) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final chatUser = UserModel(
      image: firebaseImg /* add any img url here*/, //user.photoURL.toString(),
      name: name, //user.displayName.toString(),
      about: "A new user",
      createdAt: time,
      lastActive: time,
      id: user.uid,
      isOnline: false,
      pushToken: '',
      email: user.email.toString(),
    );
    return await firestore
        .collection('users')
        .doc(user.uid)
        .set(chatUser.toJson());
  }

  static Future<void> createUserInGoogleUp() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final chatUser = UserModel(
      image: user.photoURL.toString(),
      name: user.displayName.toString(),
      about: "A new user",
      createdAt: time,
      lastActive: time,
      id: user.uid,
      isOnline: false,
      pushToken: '',
      email: user.email.toString(),
    );
    return await firestore
        .collection('users')
        .doc(user.uid)
        .set(chatUser.toJson());
  }

  // fetch all users
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    return firestore
        .collection("users")
        .where("id", isNotEqualTo: user.uid)
        .snapshots();
  }

  //update user info
  static Future<void> updateUserInfo() async {
    return await firestore
        .collection('users')
        .doc(user.uid)
        .update({'name': currentUser.name, 'about': currentUser.about});
  }
}
