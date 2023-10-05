import 'package:chat_app/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeScreenController controller = Get.put(HomeScreenController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("home"),
        actions: [
          IconButton(
              onPressed: () {
                controller.logout(context);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: const Center(
        child: Text("Home Screen"),
      ),
    );
  }
}
