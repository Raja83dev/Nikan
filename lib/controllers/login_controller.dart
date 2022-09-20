import 'package:flutter/cupertino.dart';
import 'package:get/state_manager.dart';
import 'package:nikan_app/pages/login_page.dart';
import 'package:nikan_app/pages/main_page.dart';
import 'package:nikan_app/pages/signup_page.dart';
import 'package:nikan_app/pages/vertification_code_page.dart';
import 'package:nikan_app/services/api_service.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var isSending = false.obs;
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();

  void login() async {
    isSending.value = true;
    if ((await ApiService.login(phone.text, password.text)) == true) {
      Get.offAll(MainPage());
    }
    isSending.value = false;
  }

  void signUp() async {
    isSending.value = true;
    var token = await ApiService.signup(phone.text);
    if (token != "") {
      Get.to(() => VertificationCodePage(),arguments: token);
    }
    isSending.value = false;
  }

  var code = "".obs;
  void activeCode() async {
    isSending.value = true;
    bool isOk = await ApiService.activeCode(code.value,Get.arguments.toString());
    if (isOk) {
      Get.offAll(() => MainPage());
    }
    isSending.value = false;
  }

  void forgotPass() async {
    isSending.value = true;
    await ApiService.sendPasstoPhoneNumber(phone.text);

    isSending.value = false;
    Get.off(() => LoginPage());
  }

  void gotoRegisterPage() {
    isSending.value = false;
    phone = TextEditingController();
    password = TextEditingController();
    Get.to(SignUpPage());
  }


  
  void gotoLoginPage() {
    isSending.value = false;
    phone = TextEditingController();
    password = TextEditingController();
    Get.to(LoginPage());
  }
}
