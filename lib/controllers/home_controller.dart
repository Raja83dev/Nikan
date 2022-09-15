import 'package:get/get.dart';
import 'package:nikan_app/models/products_model.dart';
import 'package:nikan_app/models/slider_image_model.dart';
import 'package:nikan_app/models/tag_model.dart';
import 'package:nikan_app/services/api_service.dart';

class HomeController extends GetxController {
  var isloadingSlider = true.obs;

  var sliderList = <SliderImageModel>[].obs;

  var tagList = <TagModel>[];
  var isloadingTags = false.obs;

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

  void getTagList() async {
    isloadingTags.value = true;
    tagList = await ApiService.getCategories();
    isloadingTags.value = false;
  }

  @override
  void onInit() {
    getSliderList();

    getProductList();
    getTagList();
  }
}
