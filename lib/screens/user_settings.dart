import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/controller/user_settings_controller.dart';
import 'package:chat_app/data/models/user_model.dart';
import 'package:chat_app/widgets/update_info_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';

class UserSettings extends StatelessWidget {
  final UserModel userModel;
  const UserSettings({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {

    UserSettingsController controller = Get.put(UserSettingsController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () => controller.logout(context),
          label: const Text("Logout"),
          icon: const Icon(
            Icons.logout,
          )),
      body: Form(
        key: controller.globalKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Stack(
                  children: [
                    ClipPath(
                      clipper: WaveClipperTwo(),
                      child: Container(
                        height: 140,
                        color: kprimaryColor,
                      ),
                    ),
                    Center(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(150),
                          child: CachedNetworkImage(
                            height: controller.getWidth(context) * .5,
                            width: controller.getWidth(context)  * .5,
                            fit: BoxFit.cover,
                            imageUrl: userModel.image,
                            //placeholder: (context, url) => CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const CircleAvatar(child: Icon(Icons.person)),
                          )),
                    ),
                    Positioned(
                      left: controller.getWidth(context)  / 1.7,
                      top: controller.getHeight(context)  / 6,
                      child: Container(
                        width: controller.getWidth(context) / 10,
                        height: controller.getWidth(context) / 10,
                        decoration: BoxDecoration(
                          color: kprimaryColor,
                          borderRadius: BorderRadius.circular(50),
                          /* border: Border.all(
                              width: 1,
                              color: thiredColor,
                            )*/
                        ),
                        child: const Icon(
                          Icons.edit,
                          color: secondaryColor,
                          size: 20,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Text(
                userModel.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                userModel.email,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20, color: Colors.black),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                child: UpdateInfoSection(userModel: userModel),
              )
            ],
          ),
        ),
      ),
    );
  }
}
