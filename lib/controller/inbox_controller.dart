import 'package:chat_app/core/services/apis.dart';
import 'package:chat_app/data/models/user_model.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class InboxController extends GetxController {
  late List<UserModel> list;

  void logout(context) async {
    //GoogleSignIn googleSignIn = GoogleSignIn();
    //googleSignIn.disconnect();
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
