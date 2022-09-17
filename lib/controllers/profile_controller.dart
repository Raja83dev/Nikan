import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nikan_app/controllers/shop_cart_controller.dart';
import 'package:nikan_app/models/save_product_model.dart';
import 'package:nikan_app/models/user_model.dart';
import 'package:nikan_app/services/api_service.dart';

class ProfileController extends GetxController {
  TextEditingController nameField = TextEditingController();
  TextEditingController phoneField = TextEditingController();
  TextEditingController emailField = TextEditingController();
  TextEditingController jobField = TextEditingController();
  TextEditingController passwordField = TextEditingController();
  TextEditingController idNumberField = TextEditingController();
  TextEditingController bornField = TextEditingController();

  var isloadingProfile = true.obs;

  UserModel? userData;
  List<SaveProductModel>? saves;

  Future<void> getData() async {
    isloadingProfile.value = true;
    userData = await ApiService.getUserDatas();
    await Get.find<ShopCartController>().getAllCarts();

    await getSaves();
    print(userData!.phone);
    isloadingProfile.value = false;

    nameField.text = userData!.fullName!;
    phoneField.text = userData!.phone!;
    emailField.text = userData!.email!;
    jobField.text = userData!.job!;
    idNumberField.text = userData!.idNumber!;
    bornField.text = userData!.born!;
  }

  Future<void> getSaves() async {
    var data = (await ApiService.productSaveList());
    saves = data;
  }

  void removeProduct(String id) async {
    isloadingProfile.value = true;

    await ApiService.removeFromCart(id);

    await getData();

    isloadingProfile.value = false;
  }

  void saveUserData() async {
    isloadingProfile.value = true;
    await ApiService.saveUserData(UserModel(
      fullName: nameField.text,
      phone: phoneField.text,
      born: bornField.text,
      email: emailField.text,
      idNumber: idNumberField.text,
      job: jobField.text,
    ));
    await getData();
    Get.back();
    isloadingProfile.value = false;
  }
}
