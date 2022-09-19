import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nikan_app/controllers/shop_cart_controller.dart';
import 'package:nikan_app/models/save_product_model.dart';
import 'package:nikan_app/models/user_model.dart';
import 'package:nikan_app/services/api_service.dart';
import 'package:persian_fonts/persian_fonts.dart';

class ProfileController extends GetxController {
  TextEditingController nameField = TextEditingController();
  TextEditingController phoneField = TextEditingController();
  TextEditingController emailField = TextEditingController();
  TextEditingController jobField = TextEditingController();
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
    uploadimage = userData!.avatar;
    isloadingProfile.value = false;

    nameField.text = userData!.fullName!;
    phoneField.text = userData!.phone!;
    emailField.text = userData!.email!;
    jobField.text = userData!.job!;
    idNumberField.text = userData!.idNumber!;
    bornField.text = userData!.born!;
  }

  Future<void> getSaves() async {
    isloadingProfile.value = true;

    var data = (await ApiService.productSaveList());
    saves = data;
    isloadingProfile.value = false;
  }

  void removeProduct(String id) async {
    isloadingProfile.value = true;

    await ApiService.removeFromCart(id);

    await getData();

    isloadingProfile.value = false;
  }

  void saveUserData() async {
    var imageData = uploadimage!;

    if (uploadimage == userData!.avatar!) {
      print("Web Applyed");
      imageData = "";
    }
    if (uploadimage == "100") {
      print("Mot Avaible");
      imageData = "";
    }

    isloadingProfile.value = true;
    await ApiService.saveUserData(UserModel(
      fullName: nameField.text,
      avatar: imageData,
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

  String? uploadimage = "";

  Future<void> selectImage() async {
    var data =
        (await ImagePicker.platform.pickImage(source: ImageSource.gallery));

    uploadimage = data!.path;
    print(uploadimage);
    isloadingProfile.value = false;
  }

  void exitAccount() {
    Get.defaultDialog(
      title: "warning".tr,
      titleStyle: PersianFonts.Vazir.copyWith(
        fontWeight: FontWeight.w800,
      ),
      middleText: "do_you_want_to_log_out_of_your_account?".tr,
      middleTextStyle: PersianFonts.Vazir.copyWith(
        fontWeight: FontWeight.w800,
      ),
      cancel: CupertinoButton(
        child: Text(
          "no".tr,
          style: PersianFonts.Vazir.copyWith(
            color: Colors.green[700],
            fontWeight: FontWeight.w800,
          ),
        ),
        onPressed: () {
          Get.back();
        },
      ),
      confirm: CupertinoButton(
        child: Text(
          "ok".tr,
          style: PersianFonts.Vazir.copyWith(
            color: Colors.red[700],
            fontWeight: FontWeight.w800,
          ),
        ),
        onPressed: () {},
      ),
    );
  }
}
