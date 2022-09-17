import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nikan_app/controllers/shop_cart_controller.dart';
import 'package:nikan_app/models/product_detail_model.dart';
import 'package:nikan_app/services/api_service.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ProductDetailController extends GetxController {
  ProductDetail? productDetail = ProductDetail();

  var isLoading = false.obs;
  var isSending = false.obs;
  var isSaving = false.obs;

  var selectedSizeIndex = 0.obs;
  var panelIsOpen = false.obs;

  void getDetail(int id) async {
    panelIsOpen.value = false;
    selectedSizeIndex.value = 0;
    isLoading.value = true;
    productDetail = await ApiService.productdetail(id);
    productDetail!.gallery!.add(Gallery(imgUrl: productDetail!.image!));

    isLoading.value = false;

    print("Product ID : " + productDetail!.id.toString());
  }

  void addToCart() async {
    isSending.value = true;

    var res = await ApiService.addToCart(productDetail!.id!);
    if (res == true) {
      productDetail!.inCart = "200";
      await Get.find<ShopCartController>().getAllCarts();
    }

    isSending.value = false;
  }

  void removeFromCart() async {
    isSending.value = true;

    var res = await ApiService.removeFromCart(productDetail!.id!);
    if (res == true) {
      productDetail!.inCart = "100";
      await Get.find<ShopCartController>().getAllCarts();
    }

    isSending.value = false;
  }

  Future<void> SaveOrUnSave() async {
    isSaving.value = true;
    if (productDetail!.save == "100") {
      await ApiService.saveProduct(productDetail!.id!);
      productDetail!.save = "200";
    } else {
      await ApiService.removeSaveProduct(productDetail!.id!);
      productDetail!.save = "100";
    }
    isSaving.value = false;
  }
}
