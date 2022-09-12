import 'package:get/get.dart';
import 'package:nikan_app/models/cart_product_model.dart';
import 'package:nikan_app/services/api_service.dart';

class ShopCartController extends GetxController {
  List<CartProductModel> products = <CartProductModel>[];
  var isloading = false.obs;
  Future<void> getAllCarts() async {
    isloading.value = true;
    products = await ApiService.cartList();
    isloading.value = false;
  }
}
