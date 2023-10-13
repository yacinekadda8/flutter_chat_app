import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:chat_app/constants.dart';
import 'package:chat_app/data/models/user_model.dart';

import 'circel_user_image.dart';

class FriendMsgCard extends StatelessWidget {
  final UserModel userModel;
  const FriendMsgCard({
    super.key,
    required this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        GoRouter.of(context).push("/chatDetails");
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: defaultPadding),
            //color: kbodyTextColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //CircleAvatar(backgroundImage: NetworkImage(userModel.image)),
                CircleUserImage(userModel: userModel),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userModel.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: highlightColor,
                      ),
                    ),
                    const Text(
                      "Hey, How its going?",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      "6:06",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                        color: kprimaryColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Text(
                        "1",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: defaultPadding),
          const Divider()
        ],
      ),
    );
  }
}
