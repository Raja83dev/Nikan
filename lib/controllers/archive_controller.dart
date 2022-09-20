import 'package:get/get.dart';
import 'package:nikan_app/models/cart_product_model.dart';
import 'package:nikan_app/services/api_service.dart';

class ArchiveController extends GetxController {
  var isloading = false.obs;

  String title = "";
  List<CartProductModel> productModels = <CartProductModel>[];

  void getData() async {
    isloading.value = true;
    title = Get.arguments[1];

    print("Archive ID : ${Get.arguments[0]}");
    productModels = await ApiService.getArchive(Get.arguments[0].toString());

    isloading.value = false;
  }
}
