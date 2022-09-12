import 'package:get/get.dart';
import 'package:nikan_app/pages/login_page.dart';
import 'package:nikan_app/pages/main_page.dart';
import 'package:nikan_app/services/api_service.dart';

class SplashController extends GetxController {

  void checkLogin() async {
    var data = await ApiService.loginWithToken();
    print("Data Is OK : $data");
    if (data == true) {
      Get.offAll(MainPage());
    } else {
      Get.offAll(LoginPage());
    }
  }
}
