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
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            child: IconButton(
              onPressed: () {
                controller.changeCurrentPage(page: 0);
              },
              icon: const Icon(Icons.email),
            ),
          ),
          SizedBox(
            child: IconButton(
              onPressed: () {
                controller.changeCurrentPage(page: 1);
                // context.go('/pendingRequests');
              },
              icon: const Icon(Icons.people),
            ),
          ),
          SizedBox(
            child: IconButton(
              onPressed: () {
                controller.changeCurrentPage(page: 2);
              },
              icon: const Icon(Icons.notifications),
            ),
          ),
          SizedBox(
            child: IconButton(
              onPressed: () {
                controller.changeCurrentPage(page: 3);
              },
              icon: const Icon(Icons.search),
            ),
          ),
        ],
      ),
    );
  }
}
