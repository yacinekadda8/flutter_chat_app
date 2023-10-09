import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/controller/user_settings_controller.dart';
import 'package:chat_app/core/functions/snack_bar.dart';
import 'package:chat_app/core/services/apis.dart';
import 'package:chat_app/data/models/user_model.dart';
import 'package:chat_app/widgets/auth/auth_btn.dart';
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
                            height: controller.mq(context).width * .5,
                            width: controller.mq(context).width * .5,
                            fit: BoxFit.cover,
                            imageUrl: userModel.image,
                            //placeholder: (context, url) => CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const CircleAvatar(child: Icon(Icons.person)),
                          )),
                    ),
                    Positioned(
                      left: controller.mq(context).width / 1.7,
                      top: controller.mq(context).height / 6,
                      child: Container(
                        width: controller.mq(context).width / 10,
                        height: controller.mq(context).width / 10,
                        decoration: BoxDecoration(
                          color: kprimaryColor,
                          borderRadius: BorderRadius.circular(50),
                          /* border: Border.all(
                              width: 1,
                              color: thiredColor,
                            )*/
                        ),
                        child: IconButton(
                            onPressed: () {
                              controller.showEditImgBottomSheet(context);
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: secondaryColor,
                              size: 20,
                            )),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: defaultPadding),
                    TextFormField(
                      //controller: mycontroller,
                      onSaved: (newValue) =>
                          APIs.currentUser.name = newValue ?? '',
                      validator: (value) => value != null && value.isNotEmpty
                          ? null
                          : 'Required Field',
                      initialValue: userModel.name,
                      decoration: InputDecoration(
                          hintText: "Youre Name",
                          prefixIcon:
                              const Icon(Icons.person, color: kprimaryColor),
                          hintStyle:
                              const TextStyle(fontSize: 14, color: Colors.grey),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 20),
                          filled: true,
                          //fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 184, 184, 184))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  const BorderSide(color: Colors.grey))),
                    ),
                    const SizedBox(height: defaultPadding / 2),
                    TextFormField(
                      //controller: mycontroller,
                      onSaved: (newValue) =>
                          APIs.currentUser.about = newValue ?? '',
                      validator: (value) => value != null && value.isNotEmpty
                          ? null
                          : 'Required Field',
                      initialValue: userModel.about,
                      decoration: InputDecoration(
                          hintText: "Bio",
                          prefixIcon: const Icon(Icons.abc_outlined,
                              color: kprimaryColor),
                          hintStyle:
                              const TextStyle(fontSize: 14, color: Colors.grey),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 20),
                          filled: true,
                          //fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 184, 184, 184))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  const BorderSide(color: Colors.grey))),
                    ),
                    const SizedBox(height: defaultPadding),
                    Authbutton(
                      onPressed: () {
                        if (controller.globalKey.currentState!.validate()) {
                          controller.globalKey.currentState!.save();
                          APIs.updateUserInfo().then((value) =>
                              showSnackbar(context, 'Updated successfully!'));
                          log('updateUserInfo done');
                        }
                      },
                      text: "Update",
                      horizontal: 0,
                      vertical: 0,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
