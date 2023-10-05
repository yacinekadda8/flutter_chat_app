import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class HomeScreenController extends GetxController {
  void logout(context) async {
    //GoogleSignIn googleSignIn = GoogleSignIn();
    //googleSignIn.disconnect();
    await FirebaseAuth.instance.signOut();
    GoRouter.of(context).pushReplacement("/login");
  }
}
