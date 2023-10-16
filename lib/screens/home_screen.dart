import 'package:chat_app/controller/homescreen_controller.dart';
import 'package:chat_app/widgets/my_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomescreenController());
    return GetBuilder<HomescreenController>(builder: (controller) {
      return Scaffold(
          bottomNavigationBar: MyBottomNavigationBar(controller: controller),
          // elementAt help to change between pages
          body: controller.myPage.elementAt(controller.currentPage));
    });
  }
}
