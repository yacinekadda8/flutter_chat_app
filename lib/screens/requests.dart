import 'package:chat_app/constants.dart';
import 'package:chat_app/controller/inbox_controller.dart';
import 'package:chat_app/core/utils/device_size.dart';
import 'package:chat_app/data/apis.dart';
import 'package:chat_app/data/models/user_model.dart';
import 'package:chat_app/widgets/Requests/pending_requests_card.dart';
import 'package:chat_app/widgets/home/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

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
        SizedBox(
          height: DeviceSize.mq(context).height / 1.3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    GoRouter.of(context).push('/sentRequests');
                  },
                  child: Container(
                    //color: kSocendColor,
                    child: const Row(
                      children: [
                        Text(
                          "View sent requests",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: koilColor,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.person_search,
                          size: 30,
                          color: koilColor,
                        )
                      ],
                    ),
                  ),
                ),
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
                                return const Center(
                                    child: CircularProgressIndicator());

                              // if some or all data load
                              case ConnectionState.active:
                              case ConnectionState.done:
                                final data = snapshot.data?.docs;
                                controller.list = data
                                        ?.map(
                                            (e) => UserModel.fromJson(e.data()))
                                        .toList() ??
                                    [];

                                if (controller.list.isNotEmpty) {
                                  return ListView.builder(
                                    itemCount: controller.list.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return PendingRequestsCard(
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
    );
  }
}
