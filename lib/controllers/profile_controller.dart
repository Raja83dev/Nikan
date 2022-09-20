import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nikan_app/constans.dart';
import 'package:nikan_app/controllers/shop_cart_controller.dart';
import 'package:nikan_app/models/save_product_model.dart';
import 'package:nikan_app/models/user_model.dart';
import 'package:nikan_app/services/api_service.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
 

  var isloadingProfile = true.obs;

  UserModel? userData;
  List<SaveProductModel>? saves;

  

  Future<void> getData() async {
  
      print("GETTTT DATAA");
      isloadingProfile.value = true;

      userData = await ApiService.getUserDatas();
      await Get.find<ShopCartController>().getAllCarts();

      await getSaves();
      print(userData!.phone);
   
      isloadingProfile.value = false;


    
    
 
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
        onPressed: () async {
ApiService.logOut();
        },
      ),
    );
  }
}
