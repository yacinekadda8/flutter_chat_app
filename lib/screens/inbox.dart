import 'dart:convert';
import 'dart:developer';

import 'package:chat_app/constants.dart';
import 'package:chat_app/controller/home_controller.dart';
import 'package:chat_app/core/services/apis.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeScreenController controller = Get.put(HomeScreenController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat App"),
        actions: [
          IconButton(
              onPressed: () {
                controller.logout(context);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: GestureDetector(
        onTap: () {
          GoRouter.of(context).push("/chatDetails");
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: defaultPadding),
              const Text(
                "Inbox",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: secondaryColor,
                ),
              ),
              const SizedBox(height: defaultPadding),
              Expanded(
                child: StreamBuilder(
                    stream: APIs.firestore.collection("users").snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final data = snapshot.data?.docs;
                        for (var i in data!) {
                          log("Data ${jsonEncode(i.data())}");
                        }
                      }
                      return ListView.builder(
                        itemCount: 2,
                        itemBuilder: (BuildContext context, int index) {
                          return FriendMsg();
                        },
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FriendMsg extends StatelessWidget {
  const FriendMsg({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: defaultPadding),
          //color: kbodyTextColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage("assets/images/ronaldo.jpg"),
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Cristiano Ronaldo",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: secondaryColor,
                    ),
                  ),
                  Text(
                    "Hey, How its going?",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const Text(
                    "6:06",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(
                      color: kprimaryColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Text(
                      "1",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: defaultPadding),
        Divider()
      ],
    );
  }
}
