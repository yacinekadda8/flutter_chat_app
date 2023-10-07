import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/controller/user_settings_controller.dart';
import 'package:chat_app/data/models/user_model.dart';
import 'package:chat_app/widgets/auth/auth_btn.dart';
import 'package:chat_app/widgets/settings/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';

class UserSettings extends StatelessWidget {
  final UserModel userModel;
  const UserSettings({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    double mqHeight = MediaQuery.of(context).size.height;
    double mqWidth = MediaQuery.of(context).size.width;
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              ClipPath(
                clipper: WaveClipperTwo(),
                child: Container(
                  height: 140,
                  color: kprimaryColor,
                ),
              ),
              Center(
                child: Stack(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(150),
                        child: CachedNetworkImage(
                          height: mqWidth * .5,
                          width: mqWidth * .5,
                          fit: BoxFit.cover,
                          imageUrl: userModel.image,
                          //placeholder: (context, url) => CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const CircleAvatar(child: Icon(Icons.person)),
                        )),
                    Positioned(
                      left: mqWidth / 3.3,
                      top: mqHeight / 7,
                      child: Container(
                        width: mqWidth / 10,
                        height: mqWidth / 10,
                        decoration: BoxDecoration(
                          //color: thiredColor,
                          borderRadius: BorderRadius.circular(50),
                          /* border: Border.all(
                              width: 1,
                              color: thiredColor,
                            )*/
                        ),
                        child: const Icon(
                          Icons.change_circle_outlined,
                          color: kprimaryColor,
                          size: 40,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Text(
            userModel.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Text(
            userModel.email,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, color: Colors.black),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            child: UpdateInfoSection(userModel: userModel),
          )
        ],
      ),
    );
  }
}

class UpdateInfoSection extends StatelessWidget {
  const UpdateInfoSection({
    super.key,
    required this.userModel,
  });

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: defaultPadding),
        SettingTextFormField(
          hintText: "Youre Name",
          icon: Icons.person,
          initialValue: userModel.name,
        ),
        const SizedBox(height: defaultPadding / 2),
        SettingTextFormField(
          hintText: "Bio",
          icon: Icons.abc_outlined,
          initialValue: userModel.about,
        ),
        const SizedBox(height: defaultPadding / 2),
        Authbutton(
          onPressed: () {},
          text: "SAVE",
          horizontal: 0,
          vertical: 0,
        ),
      ],
    );
  }
}
