import 'package:chat_app/constants.dart';
import 'package:chat_app/controller/wellcome_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dots_indicator/dots_indicator.dart';

class WelcomePage extends GetView<WelcomeController> {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(WelcomeController());
    return Scaffold(
        backgroundColor: kprimaryColor,
        body: Obx(
          () => SizedBox(
            width: 360.w,
            height: 780.w,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                PageView(
                  scrollDirection: Axis.horizontal,
                  reverse: false,
                  onPageChanged: (index) {
                    controller.changePage(index);
                  },
                  controller: PageController(
                    initialPage: 0,
                    keepPage: false,
                    viewportFraction: 1,
                  ),
                  pageSnapping: true,
                  physics: const ClampingScrollPhysics(),
                  children: [
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage("assets/images/i1.png"))),
                      child: const Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Positioned(
                              bottom: 333,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'limitless connections\nAnd heartfelt conversations',
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                  style: TextStyle(
                                    color: highlightColor,
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ),
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage("assets/images/i2.png"))),
                      child: const Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Positioned(
                              bottom: 333,
                              child: Text(
                                "Expressing emotions sharing\nCreating meaningful bonds.",
                                softWrap: true,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: highlightColor,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          ]),
                    ),
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/images/i3.png"))),
                      child:
                          Stack(alignment: Alignment.bottomCenter, children: [
                        Positioned(
                            bottom: 210,
                            child: Column(
                              children: [
                                const Text(
                                  "We're excited to have you \nAs part of our family.",
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: highlightColor,
                                    fontSize: 24,
                                  ),
                                ),
                                const SizedBox(
                                  height: 60,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    controller.handleSignIn(context);
                                  },
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white),
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      side: MaterialStateProperty.all(
                                          const BorderSide(
                                        color: Colors.white,
                                        width: 4,
                                      ))),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 28.0, vertical: 14.0),
                                    child: Text(
                                      'START NOW',
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: kblackColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ))
                      ]),
                    ),
                  ],
                ),
                Positioned(
                    bottom: 90,
                    child: DotsIndicator(
                      position: controller.state.index.value,
                      dotsCount: 3,
                      reversed: false,
                      mainAxisAlignment: MainAxisAlignment.center,
                      decorator: DotsDecorator(
                          activeColor: highlightColor,
                          size: const Size.square(9),
                          activeSize: const Size(18, 9),
                          activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5))),
                    ))
              ],
            ),
          ),
        ));
  }
}
