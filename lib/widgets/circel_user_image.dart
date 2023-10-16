import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/data/models/user_model.dart';
import 'package:flutter/material.dart';

class CircleUserImage extends StatelessWidget {
  final UserModel userModel;
  final double h;
  final double w;
  const CircleUserImage({
    super.key,
    required this.userModel,
    this.h = .07,
    this.w = .07,
  });

  @override
  Widget build(BuildContext context) {
    double mqHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: CachedNetworkImage(
              height: mqHeight * h,
              width: mqHeight * w,
              fit: BoxFit.cover,
              imageUrl: userModel.image.toString(),
              //placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) =>
                  const CircleAvatar(child: Icon(Icons.person)),
            )),
        /* Positioned(
          left: 40,
          top: 40,
          child: Container(
            width: 15,
            height: 15,
            decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  width: 2,
                  color: kWhiteColor,
                )),
          ),
        ) */
      ],
    );
  }
}
