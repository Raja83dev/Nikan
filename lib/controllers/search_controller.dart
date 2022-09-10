import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nikan_app/models/product_model.dart';
import 'package:nikan_app/services/api_service.dart';

class SearchController extends GetxController {
  List<Product> products = <Product>[];
 
  var isloading = false.obs;

  void getSearchedProducts(String search) async {
    products.clear();
    isloading.value = true;
    products.addAll(await ApiService.searchProducts(search));
    isloading.value = false;
    print(products.length);
  }
  @override
  void onInit()async {
       products.clear();
     isloading.value = true;
    products.addAll(await ApiService.searchProducts(""));
    isloading.value = false;
  }
}
