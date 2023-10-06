import 'package:chat_app/constants.dart';
import 'package:chat_app/widgets/auth/my_text_field.dart';
import 'package:chat_app/widgets/home/chat_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/auth/custom_textformfield.dart';
import '../widgets/home/chat_bubble.dart';

class ChatDetails extends StatelessWidget {
  const ChatDetails({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        leading: Row(
          children: [
            IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back_ios),
            ),
            const CircleAvatar(
              backgroundImage: AssetImage("assets/images/ronaldo.jpg"),
            ),
          ],
        ),
        leadingWidth: 90,
        title: const Text(
          "Cristiano Ronaldo",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: secondaryColor,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(defaultPadding),
        child: ListView.builder(
          itemCount: 4,
          itemBuilder: (BuildContext context, int index) {
            return const ChatBubble(
              isMe: true,
              topLeft: 30,
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(defaultPadding / 2),
        child: ChatTextField(
          labelText: "Aa",
          controller: textEditingController,
        ),
      ),
    );
  }
}
