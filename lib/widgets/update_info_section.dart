import 'package:chat_app/constants.dart';
import 'package:chat_app/data/models/user_model.dart';
import 'package:chat_app/widgets/auth/auth_btn.dart';
import 'package:chat_app/widgets/settings/text_form_field.dart';
import 'package:flutter/material.dart';


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
        const SizedBox(height: defaultPadding),
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
