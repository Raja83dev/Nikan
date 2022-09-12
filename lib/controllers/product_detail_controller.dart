import 'package:get/get.dart';
import 'package:nikan_app/controllers/shop_cart_controller.dart';
import 'package:nikan_app/models/product_detail_model.dart';
import 'package:nikan_app/services/api_service.dart';

class ProductDetailController extends GetxController {
  ProductDetail? productDetail = ProductDetail();
  var isLoading = false.obs;
  var isSending = false.obs;

  var selectedSizeIndex = 0.obs;

  void getDetail(int id) async {
    print(id);
    isLoading.value = true;
    productDetail = await ApiService.productdetail(id);
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
}
