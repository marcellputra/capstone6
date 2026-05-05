import 'package:get/get.dart';

class AuthController extends GetxController {
  var isLogin = false.obs;

  void login() {
    isLogin.value = true;
  }

  void logout() {
    isLogin.value = false;
  }
}