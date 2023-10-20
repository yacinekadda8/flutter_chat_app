import 'package:chat_app/constants.dart';
import 'package:chat_app/controller/inbox_controller.dart';
import 'package:chat_app/core/utils/device_size.dart';
import 'package:chat_app/data/apis.dart';
import 'package:chat_app/data/models/user_model.dart';
import 'package:chat_app/widgets/Requests/pending_requests_card.dart';
import 'package:chat_app/widgets/Requests/sent_request_cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SentRequests extends StatelessWidget {
  const SentRequests({super.key});

  @override
  Widget build(BuildContext context) {
    InboxController controller = Get.put(InboxController());
    controller.list = [];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sent requests",
          style: TextStyle(
            //fontSize: 26,
            fontWeight: FontWeight.bold,
            color: kblackColor,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: defaultPadding),
          SizedBox(
            height: DeviceSize.mq(context).height / 1.3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "SentRequests",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: kSocendColor,
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
                  Expanded(
                      child: StreamBuilder(
                    stream: APIs.getSentRequestsFriendsId(),
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
                                  return const Center(
                                      child: CircularProgressIndicator());

                                // if some or all data load
                                case ConnectionState.active:
                                case ConnectionState.done:
                                  final data = snapshot.data?.docs;
                                  controller.list = data
                                          ?.map((e) =>
                                              UserModel.fromJson(e.data()))
                                          .toList() ??
                                      [];

                                  if (controller.list.isNotEmpty) {
                                    return ListView.builder(
                                      itemCount: controller.list.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return SentRequestsCard(
                                            userModel: controller.list[index],
                                            image: controller.list[index].image,
                                            name: controller.list[index].name,
                                            id: controller.list[index].id);
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
