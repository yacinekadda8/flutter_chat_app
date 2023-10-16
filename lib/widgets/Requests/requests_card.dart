import 'package:chat_app/constants.dart';
import 'package:chat_app/data/apis.dart';
import 'package:chat_app/data/models/user_model.dart';
import 'package:chat_app/widgets/circel_user_image.dart';
import 'package:flutter/material.dart';

class RequestsCard extends StatelessWidget {
  const RequestsCard({
    super.key,
    required this.userModel,
    required this.image,
    required this.name,
    required this.id,
  });
  final UserModel userModel;
  final String image;
  final String name;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: kSocendColor.withOpacity(.2),
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleUserImage(
            userModel: userModel,
            h: .12,
            w: .12,
          ),
          // Image.network(
          //   image,
          //   height: DeviceSize.mq(context).width / 3,
          //   width: DeviceSize.mq(context).width / 3,
          //   fit: BoxFit.cover,
          // ),
          Column(
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: kblackColor,
                  fontSize: 20,
                ),
              ),
              Row(
                children: [
                  TextButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: kprimaryColor,
                          textStyle: const TextStyle(
                            color: kWhiteColor,
                          )),
                      onPressed: () {
                        APIs.acceptFriendRequest(friendId: id);
                      },
                      child: const Text(
                        "Confirm",
                        style: TextStyle(
                          color: kWhiteColor,
                          fontWeight: FontWeight.normal,
                        ),
                      )),
                  const SizedBox(width: defaultPadding / 2),
                  TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: kbodyTextColor,
                      ),
                      onPressed: () {
                        APIs.rejectFriendRequest(friendId: id);
                      },
                      child: const Text(" Delete ",
                          style: TextStyle(
                              color: kblackColor,
                              fontWeight: FontWeight.normal))),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
