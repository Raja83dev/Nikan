import 'package:get/get.dart';
import 'package:nikan_app/models/products_model.dart';
import 'package:nikan_app/models/slider_image_model.dart';
import 'package:nikan_app/services/api_service.dart';

class HomeController extends GetxController{
   var isloadingSlider = true.obs;

  var sliderList = <SliderImageModel>[].obs;

 



  var productList = <ProductsModel>[].obs;

  var isloadingProduct = true.obs;


  void getSliderList() async {
    isloadingSlider.value = true;
    sliderList.addAll(await ApiService.getSliderImages());
    isloadingSlider.value = false;
  }

 

  void getProductList() async {
    isloadingProduct.value = true;
    productList.addAll(await ApiService.productList());
    isloadingProduct.value = false;
  }

  @override
  void onInit() {

ApiService.productdetail(12);

    getSliderList();
   
    getProductList();
  }
}