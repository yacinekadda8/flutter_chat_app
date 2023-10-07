
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/data/models/user_model.dart';
import 'package:flutter/material.dart';

class CircleUserImage extends StatelessWidget {
  final UserModel userModel;
  const CircleUserImage({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: CachedNetworkImage(
              height: 50,
              width: 50,
              fit: BoxFit.cover,
              imageUrl: userModel.image.toString(),
              //placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) =>
                  const CircleAvatar(child: Icon(Icons.person)),
            )),
        Positioned(
          left: 35,
          top: 35,
          child: Container(
            width: 15,
            height: 15,
            decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  width: 1,
                  color: thiredColor,
                )),
          ),
        )
      ],
    );
  }
}
