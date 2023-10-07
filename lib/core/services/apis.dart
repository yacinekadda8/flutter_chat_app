import 'package:chat_app/data/models/user_model.dart';
import 'package:chat_app/env.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class APIs {
  // for authentication
  static FirebaseAuth auth = FirebaseAuth.instance;
  // for FirebaseFirestore database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  // current user
  static User get user => auth.currentUser!;
  //cheek if user existe
  static Future<bool> userExists() async {
    return (await firestore.collection('users').doc(user.uid).get()).exists;
  }

  // create a new user
  static Future<void> createUser({required String name}) async {
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
}
