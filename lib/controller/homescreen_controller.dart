import 'package:chat_app/screens/inbox.dart';
import 'package:chat_app/screens/requests.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomescreenController extends GetxController {
  //final userModel = APIs.currentUser;
  int currentPage = 0;
  List<Widget> myPage = [
    const InboxScreen(),
    const Requests(),
    const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Text('Notification')),
      ],
    ),
    const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Text('Search')),
      ],
    ),
  ];
  /*  when click on MyBottomNavigationBar this function change Current
   Page in homescreen */
  changeCurrentPage({required int page}) {
    currentPage = page;
    update();
  }
}
