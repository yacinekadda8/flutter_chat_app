import 'package:chat_app/data/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  List<MessageModel> messagesList = [];
  TextEditingController textEditingController = TextEditingController();
  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }
}
