// import 'package:chat_app/constants.dart';
// import 'package:chat_app/core/services/apis.dart';
// import 'package:flutter/material.dart';

// class SettingTextFormField extends StatelessWidget {
//   final String? hintText;
//   final IconData icon;
//   final String? initialValue;
//   const SettingTextFormField({
//     super.key,
//     required this.hintText,
//     required this.icon,
//     required this.initialValue,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       //controller: mycontroller,
//       onSaved: (newValue) => APIs.currentUser.name = newValue ?? '',
//       validator: (value) => value != null && value.isNotEmpty ? null : 'Required Field',
//       initialValue: initialValue,
//       decoration: InputDecoration(
//           hintText: hintText,
//           prefixIcon: Icon(icon, color: kprimaryColor),
//           hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
//           contentPadding:
//               const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
//           filled: true,
//           //fillColor: Colors.grey[200],
//           border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(15),
//               borderSide:
//                   const BorderSide(color: Color.fromARGB(255, 184, 184, 184))),
//           enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(15),
//               borderSide: const BorderSide(color: Colors.grey))),
//     );
//   }
// }
