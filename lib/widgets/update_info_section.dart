// import 'dart:developer';

// import 'package:chat_app/constants.dart';
// import 'package:chat_app/controller/user_settings_controller.dart';
// import 'package:chat_app/core/services/apis.dart';
// import 'package:chat_app/data/models/user_model.dart';
// import 'package:chat_app/widgets/auth/auth_btn.dart';
// import 'package:chat_app/widgets/settings/text_form_field.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class UpdateInfoSection extends StatelessWidget {
//   const UpdateInfoSection({
//     super.key,
//     required this.userModel,
//   });

//   final UserModel userModel;

//   @override
//   Widget build(BuildContext context) {
//     UserSettingsController controller = Get.put(UserSettingsController());

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         const SizedBox(height: defaultPadding),
//         TextFormField(
//           //controller: mycontroller,
//           onSaved: (newValue) => APIs.currentUser.name = newValue ?? '',
//           validator: (value) =>
//               value != null && value.isNotEmpty ? null : 'Required Field',
//           initialValue: userModel.name,
//           decoration: InputDecoration(
//               hintText: "Youre Name",
//               prefixIcon: const Icon(Icons.person, color: kprimaryColor),
//               hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
//               contentPadding:
//                   const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
//               filled: true,
//               //fillColor: Colors.grey[200],
//               border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(15),
//                   borderSide: const BorderSide(
//                       color: Color.fromARGB(255, 184, 184, 184))),
//               enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(15),
//                   borderSide: const BorderSide(color: Colors.grey))),
//         ),
//         const SizedBox(height: defaultPadding / 2),
//         TextFormField(
//           //controller: mycontroller,
//           onSaved: (newValue) => APIs.currentUser.about = newValue ?? '',
//           validator: (value) =>
//               value != null && value.isNotEmpty ? null : 'Required Field',
//           initialValue: userModel.about,
//           decoration: InputDecoration(
//               hintText: "Bio",
//               prefixIcon: const Icon(Icons.abc_outlined, color: kprimaryColor),
//               hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
//               contentPadding:
//                   const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
//               filled: true,
//               //fillColor: Colors.grey[200],
//               border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(15),
//                   borderSide: const BorderSide(
//                       color: Color.fromARGB(255, 184, 184, 184))),
//               enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(15),
//                   borderSide: const BorderSide(color: Colors.grey))),
//         ),
//         const SizedBox(height: defaultPadding),
//         Authbutton(
//           onPressed: () {
//             if (controller.globalKey.currentState!.validate()) {
//               log('isnide v');
//             }
//           },
//           text: "Update",
//           horizontal: 0,
//           vertical: 0,
//         ),
//       ],
//     );
//   }
// }
