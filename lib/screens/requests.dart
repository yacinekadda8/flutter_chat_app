import 'package:chat_app/constants.dart';
import 'package:chat_app/controller/inbox_controller.dart';
import 'package:chat_app/data/apis.dart';
import 'package:chat_app/data/models/user_model.dart';
import 'package:chat_app/widgets/Requests/requests_card.dart';
import 'package:chat_app/widgets/home/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Requests extends StatelessWidget {
  const Requests({super.key});

  @override
  Widget build(BuildContext context) {
    InboxController controller = Get.put(InboxController());
    controller.list = [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MyAppBar(),
        const SizedBox(height: defaultPadding),
        const Text(
          "Pending Requests",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: kSocendColor,
          ),
        ),
        const SizedBox(height: defaultPadding),
        Expanded(
            child: StreamBuilder(
          stream: APIs.getPendingRequestsFriendsId(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final friendIds =
                  snapshot.data?.docs.map((e) => e.id).toList() ?? [];

              if (friendIds.isNotEmpty) {
                return StreamBuilder(
                  stream: APIs.getAllUsers(friendsId: friendIds),
                  builder: (context, snapshot) {
                    // Rest of your StreamBuilder code here
                    switch (snapshot.connectionState) {
                      // if data is loading
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                        return const Center(child: CircularProgressIndicator());

                      // if some or all data load
                      case ConnectionState.active:
                      case ConnectionState.done:
                        final data = snapshot.data?.docs;
                        controller.list = data
                                ?.map((e) => UserModel.fromJson(e.data()))
                                .toList() ??
                            [];

                        if (controller.list.isNotEmpty) {
                          return ListView.builder(
                            itemCount: controller.list.length,
                            itemBuilder: (BuildContext context, int index) {
                              return RequestsCard(
                                userModel: controller.list[index],
                                      image: controller.list[index].image,
                                      name: controller.list[index].name,
                                      id: controller.list[index].id)
                                  /* Container(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                margin: const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                    color: kSocendColor.withOpacity(.2),
                                    borderRadius: BorderRadius.circular(15)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.network(
                                      controller.list[index].image,
                                      height: controller.mq(context).width / 3,
                                      width: controller.mq(context).width / 3,
                                      fit: BoxFit.cover,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          controller.list[index].name,
                                          style: const TextStyle(
                                            color: kblackColor,
                                            fontSize: 20,
                                          ),
                                        ),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: kprimaryColor,
                                            ),
                                            onPressed: () {
                                              APIs.acceptFriendRequest(
                                                  friendId: controller
                                                      .list[index].id);
                                            },
                                            child: const Text(
                                              "Confirm",
                                              style: TextStyle(
                                                color: kWhiteColor,
                                              ),
                                            )),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: kbodyTextColor,
                                            ),
                                            onPressed: () {
                                              APIs.rejectFriendRequest(
                                                  friendId: controller
                                                      .list[index].id);
                                            },
                                            child: const Text("  Delete  ",
                                                style: TextStyle(
                                                  color: kWhiteColor,
                                                ))),
                                      ],
                                    ),
                                  ],
                                ),
                              ) */
                                  ;
                              // controller.list[index];
                            },
                          );
                        } else {
                          return const Text(
                            "No Data yet...",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: kSocendColor,
                            ),
                          );
                        }
                    }
                  },
                );
              } else {
                return const Center(
                  child: Text(
                    "No Requests yet",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: kSocendColor,
                    ),
                  ),
                );
              }
            } else if (snapshot.hasError) {
              return const Center(child: Text('error!'));
            }

            return const Center(child: CircularProgressIndicator());
          },
        )),
      ],
    );
  }
}
