import 'package:chat_app/controller/signup_controller.dart';
import 'package:chat_app/widgets/auth/divider_text.dart';
import 'package:chat_app/widgets/auth/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/widgets/auth/auth_btn.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    //double dWidth = MediaQuery.of(context).size.width;
    double dHeight = MediaQuery.of(context).size.height;
    Get.put(SignupController());
    return GetBuilder<SignupController>(builder: (controller) {
      return ModalProgressHUD(
        inAsyncCall: controller.isLoading,
        child: Scaffold(
            body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipPath(
                clipper: WaveClipperTwo(),
                child: Container(
                  height: dHeight / 2.5,
                  decoration: const BoxDecoration(
                    color: kprimaryColor,
                    //   borderRadius: BorderRadius.only(bottomLeft: Radius.circular(150)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: defaultPadding * 3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 120, // specify your desired width here
                          height: 120, // specify your desired height here
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/logo.png"),
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                        // const SizedBox(height: defaultPadding),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: defaultPadding * 2,
                            horizontal: defaultPadding,
                          ),
                          child: Text(
                            'Create Account',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: kWhiteColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 40),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: defaultPadding),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  MyTextField(
                      controller: controller.usernameController,
                      labelText: 'UserName'),
                  MyTextField(
                      controller: controller.emailController,
                      labelText: 'Email'),
                  MyTextField(
                      controller: controller.phoneController,
                      labelText: 'Phone'),
                  MyTextField(
                      controller: controller.passwordController,
                      labelText: 'Password'),
                  const SizedBox(height: defaultPadding),
                  Authbutton(
                    text: 'Sign up',
                    onPressed: () {
                      controller.signUp(context);
                    },
                  ),
                  const DividerText(),
                  Authbutton(
                    text: 'Log In',
                    onPressed: () => context.pop(),
                    backgroundColor: kWhiteColor,
                    foregroundColor: kSocendColor,
                    side: const BorderSide(
                      color: kSocendColor,
                      width: 2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        )),
      );
    });
  }
}
