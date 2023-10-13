import 'package:chat_app/constants.dart';
import 'package:chat_app/controller/reset_password_controller.dart';
import 'package:chat_app/widgets/auth/auth_btn.dart';
import 'package:chat_app/widgets/auth/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  Widget build(BuildContext context) {
    ResetPasswordController controller = Get.put(ResetPasswordController());
    return ModalProgressHUD(
      inAsyncCall: controller.isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Reset Password'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Form(
            key: controller.formState,
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: defaultPadding),
                const Text(
                  "Enter the email address associated with your account and Well send you a link to reset your password.",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: defaultPadding * 2),
                CustomTextForm(
                  hinttext: "Enter Your Email",
                  mycontroller: controller.email,
                  validator: (val) {
                    if (val!.isEmpty || !val.contains('@')) {
                      return "not valid";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: defaultPadding * 2),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Authbutton(
                    onPressed: () async {
                      controller.resetPassword(context);
                    },
                    text: "Send",
                    backgroundColor: kprimaryColor,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Dont have an account? ",
                      style: TextStyle(fontSize: 16),
                    ),
                    InkWell(
                      onTap: () {
                        GoRouter.of(context).pushReplacement("/signup");
                      },
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                          fontSize: 16,
                          color: kprimaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
