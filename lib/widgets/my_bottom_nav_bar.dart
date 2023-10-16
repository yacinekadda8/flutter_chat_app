import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';

import 'package:chat_app/controller/homescreen_controller.dart';

class MyBottomNavigationBar extends StatelessWidget {
  final HomescreenController controller;
  const MyBottomNavigationBar({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: kSocendColor,
      height: 64,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          IconButton(
            onPressed: () {
              controller.changeCurrentPage(page: 0);
            },
            icon: Icon(
              Icons.email,
              size: 40,
              color: controller.currentPage == 0 ? kprimaryColor : koilColor,
            ),
          ),
          IconButton(
            onPressed: () {
              controller.changeCurrentPage(page: 1);
              // context.go('/pendingRequests');
            },
            icon: Icon(
              Icons.people,
              size: 40,
              color: controller.currentPage == 1 ? kprimaryColor : koilColor,
            ),
          ),
          IconButton(
            onPressed: () {
              controller.changeCurrentPage(page: 2);
            },
            icon: Icon(
              Icons.notifications,
              size: 40,
              color: controller.currentPage == 2 ? kprimaryColor : koilColor,
            ),
          ),
          IconButton(
            onPressed: () {
              controller.changeCurrentPage(page: 3);
            },
            icon: Icon(
              Icons.search,
              size: 40,
              color: controller.currentPage == 3 ? kprimaryColor : koilColor,
            ),
          ),
        ],
      ),
    );
  }
}
