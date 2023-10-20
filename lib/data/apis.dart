import 'dart:developer';
import 'dart:io';

import 'package:chat_app/data/models/message_model.dart';
import 'package:chat_app/data/models/user_model.dart';
import 'package:chat_app/env.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class APIs {
  // for authentication
  static FirebaseAuth auth = FirebaseAuth.instance;
  // for FirebaseFirestore database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  // for FirebaseStorage instance pointer to a file in the cloud
  static FirebaseStorage storage = FirebaseStorage.instance;

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

  // fetch only accepted friends
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAcceptedFriendsId() {
    return firestore
        .collection("users")
        .doc(user.uid)
        .collection("my_friends")
        .where("status", isEqualTo: "accepted")
        .snapshots();
  }

  // fetch only Pending Requests
  static Stream<QuerySnapshot<Map<String, dynamic>>>
      getPendingRequestsFriendsId() {
    return firestore
        .collection("users")
        .doc(user.uid)
        .collection("my_friends")
        .where("invitation", isEqualTo: "pending")
        .where("status", isEqualTo: "receiver")
        .snapshots();
  }

  // fetch only Sent Requests
  static Stream<QuerySnapshot<Map<String, dynamic>>>
      getSentRequestsFriendsId() {
    return firestore
        .collection("users")
        .doc(user.uid)
        .collection("my_friends")
        .where("invitation", isEqualTo: "pending")
        .where("status", isEqualTo: "sender")
        .snapshots();
  }

  static Future<void> acceptFriendRequest({required String friendId}) async {
    // Accept the friend request
    firestore
        .collection("users")
        .doc(user.uid)
        .collection("my_friends")
        .doc(friendId)
        .update({
      "status": "accepted",
    });

// Update the friend request status for the other user
    firestore
        .collection("users")
        .doc(friendId)
        .collection("my_friends")
        .doc(user.uid)
        .update({
      "status": "accepted",
    });
  }

  static Future<void> rejectFriendRequest({required String friendId}) async {
// // Reject the friend request
//     firestore
//         .collection("users")
//         .doc(user.uid)
//         .collection("my_friends")
//         .doc(friendId)
//         .delete();
    // or set the status to "rejected"
    // rejected the friend request
    firestore
        .collection("users")
        .doc(user.uid)
        .collection("my_friends")
        .doc(friendId)
        .update({
      "status": "rejected",
    });

// Update the friend request status for the other user
    firestore
        .collection("users")
        .doc(friendId)
        .collection("my_friends")
        .doc(user.uid)
        .update({
      "status": "rejected",
    });
  }

  static Future<void> cancelFriendRequest({required String friendId}) async {
    // Accept the friend request
    firestore
        .collection("users")
        .doc(user.uid)
        .collection("my_friends")
        .doc(friendId)
        .update({
      "status": "canceled",
    });

// Update the friend request status for the other user
    firestore
        .collection("users")
        .doc(friendId)
        .collection("my_friends")
        .doc(user.uid)
        .update({
      "status": "canceled",
    });
  }

  // fetch all users from firestore
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers(
      {required List<String> friendsId}) {
    return firestore
        .collection("users")
        .where("id", whereIn: friendsId)
        //.where("id", isNotEqualTo: user.uid)
        .snapshots();
  }

  // online * ofline status
  static Stream<QuerySnapshot<Map<String, dynamic>>> getUserInfo(
      UserModel userModel) {
    return firestore
        .collection("users")
        .where("id", isEqualTo: userModel.id)
        //.where("id", isNotEqualTo: user.uid)
        .snapshots();
  }

  //TODO
  // Update Active Status
  static Future<void> updateActiveStatus(bool isOnline) async {
    String lastActive = DateTime.now().microsecondsSinceEpoch.toString();
    firestore
        .collection("users")
        .doc(user.uid)
        .update({"is_online": isOnline, "last_active": lastActive});
  }

  //update user info
  static Future<void> updateUserInfo() async {
    await firestore
        .collection('users')
        .doc(user.uid)
        .update({'name': currentUser.name, 'about': currentUser.about});
  }

  // Update UserPicture in firestore and storage
  static Future<void> updateUserPicture(File file) async {
    // get image extiontion
    final ext = file.path.split('.').last;
    log('EXT: $ext');

    // storage file ref with path
    final ref = storage.ref().child("users_pictures/${user.uid}.$ext");

    // upload image
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      log("Data Transferred = ${p0.bytesTransferred / 1000} kb");
    });
    // update user image in firestore
    currentUser.image = await ref.getDownloadURL();
    await firestore.collection('users').doc(user.uid).update({
      'image': currentUser.image,
    });
  }

  // *******  Inbox and Chat Screen apis *******//
  // for getting conversation id
  static String getConversationId(String id) => user.uid.hashCode <= id.hashCode
      ? '${user.uid}_$id'
      : '${id}_${user.uid}';
  // fetch all messages from specific Conversation from firestore
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
      UserModel user) {
    return firestore
        .collection("chats/${getConversationId(user.id)}/messages/")
        .snapshots();
  }

  //for sending message
  static Future<void> sendMsg(UserModel userModel, String msg) async {
    //message sending time (also id)
    final time = DateTime.now().microsecondsSinceEpoch.toString();
    //message to send
    final MessageModel message = MessageModel(
        msg: msg,
        read: '',
        told: userModel.id,
        fromid: user.uid,
        sent: time,
        type: Type.text);
    final ref = firestore
        .collection("chats/${getConversationId(userModel.id)}/messages/");
    await ref.doc(time).set(message.toJson());
  }

  static Future<void> updateReadStatus(MessageModel messageModel) async {
    firestore
        .collection("chats/${getConversationId(messageModel.fromid)}/messages/")
        .doc(messageModel.sent)
        .update({'read': DateTime.now().microsecondsSinceEpoch.toString()});
  }

  // get last msg of specific chat
  static Stream<QuerySnapshot<Map<String, dynamic>>> getLastMsg(
      UserModel userModel) {
    return firestore
        .collection("chats/${getConversationId(userModel.id)}/messages/")
        .orderBy('sent', descending: true)
        .limit(1)
        .snapshots();
  }

// Add new friend for both users
  static Future<bool> addNewFriend(String email) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final data = await firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    if (data.docs.isNotEmpty) {
      final friendId = data.docs.first.id;

      if (friendId == user.uid) {
        // The user is trying to add themselves as a friend, you can handle this as needed.
        return false;
      }

      // Add the friend for the current user
      firestore
          .collection("users")
          .doc(user.uid)
          .collection("my_friends")
          .doc(friendId)
          .set({
        "invitation": "pending",
        "status": "sender",
        "send_time": time.toString()
      });

      // Add the current user as a friend for the user receiving the invitation
      firestore
          .collection("users")
          .doc(friendId)
          .collection("my_friends")
          .doc(user.uid)
          .set({
        "invitation": "pending",
        "status": "receiver",
        "receive_time": time.toString()
      });

      return true;
    } else {
      // User Doesn't Exist
      return false;
    }
  }

  // Create a function to delete a chat conversation:
  static Future<void> deleteChatInConversation(UserModel user) async {
    final conversationId = APIs.getConversationId(user.id);

    // Delete the chat conversation document
    await firestore.collection("chats").doc(conversationId).delete();

    // Delete all messages associated with the conversation
    await firestore.collection("chats/$conversationId/messages").get().then(
      (querySnapshot) {
        querySnapshot.docs.forEach((messageDoc) {
          messageDoc.reference.delete();
        });
      },
    );
  }

  //
  static Future<void> removeFriend(String friendId) async {
    // Remove the friend from the current user's friends list
    await firestore
        .collection("users")
        .doc(user.uid)
        .collection("my_friends")
        .doc(friendId)
        .delete();

    // Optionally, remove the current user from the friend's friends list
    await firestore
        .collection("users")
        .doc(friendId)
        .collection("my_friends")
        .doc(user.uid)
        .delete();
  }
}
