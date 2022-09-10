import 'package:flutter/cupertino.dart';
import 'package:get/state_manager.dart';
import 'package:nikan_app/services/api_service.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var isSending = false.obs;
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();

  void login() async {
    isSending.value=true;
    if ((await ApiService.login(phone.text, password.text))== true) {
      Get.offNamed('/main');
     
    }
    isSending.value=false;
  }

  void signUp() async {
     isSending.value=true;
    if ((await ApiService.signup(phone.text))== true) {
      Get.offNamed('/verify_code');
     
    }
    isSending.value=false;
  }

  void code() {}
}
