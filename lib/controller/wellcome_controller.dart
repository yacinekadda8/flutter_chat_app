import 'package:chat_app/screens/welcome/state.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class WelcomeController extends GetxController {
  final state = WelcomeState();
  WelcomeController();
  changePage(int index) async {
    state.index.value = index;
  }

  handleSignIn(context) async {
    GoRouter.of(context).pushReplacement("/login");
  }
}
