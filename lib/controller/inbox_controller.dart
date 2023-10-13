import 'package:chat_app/core/services/apis.dart';
import 'package:chat_app/data/models/user_model.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

class InboxController extends GetxController {
  late List<UserModel> list;
  final List<UserModel> searchList = [];
  GoogleSignIn googleSignIn = GoogleSignIn();

  void logout(context) async {
    googleSignIn.disconnect();
    await APIs.auth.signOut();
    GoRouter.of(context).pushReplacement("/login");
  }

  // @override
  // void onInit() {
  //   super.onInit();
  //   APIs.getCurrentUserInfo();
  //   update();
  // }
}
