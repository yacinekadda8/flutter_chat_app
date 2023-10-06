import 'package:chat_app/constants.dart';
import 'package:chat_app/controller/login_controller.dart';
import 'package:chat_app/widgets/auth/auth_btn.dart';
import 'package:chat_app/widgets/auth/divider_text.dart';
import 'package:chat_app/widgets/auth/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    //double dWidth = MediaQuery.of(context).size.width;
    double dHeight = MediaQuery.of(context).size.height;
    Get.put(LoginController());
    print("======================= $dHeight");
    return GetBuilder<LoginController>(builder: (controller) {
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
                            'Login',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: thiredColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 40),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                color: thiredColor,
                height: dHeight / 1.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: defaultPadding),
                    MyTextField(
                        controller: controller.emailController,
                        labelText: 'Email'),
                    MyTextField(
                        controller: controller.passwordController,
                        labelText: 'Password'),
                    TextButton(
                      onPressed: () {
                        GoRouter.of(context).pushReplacement("/resetPassword");
                      },
                      style: TextButton.styleFrom(
                          foregroundColor: secondaryColor, // text color
                          alignment: Alignment.topRight,
                          padding: const EdgeInsets.symmetric(
                              horizontal: defaultPadding / 2),
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          )),
                      child: const Text(
                        'Forgot Password?',
                        textAlign: TextAlign.right,
                      ),
                    ),
                    const SizedBox(height: defaultPadding),
                    Authbutton(
                      text: 'Log In',
                      onPressed: () {
                        controller.login(context);
                      },
                    ),
                    const DividerText(),
                    Authbutton(
                      onPressed: () => context.go("/signup"),
                      text: 'Sign up',
                      backgroundColor: thiredColor,
                      foregroundColor: highlightColor,
                      side: const BorderSide(
                        color: highlightColor,
                        width: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )),
      );
    });
  }
}
