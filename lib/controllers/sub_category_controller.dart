import 'package:get/get.dart';
import 'package:nikan_app/models/sub_category_model.dart';
import 'package:nikan_app/services/api_service.dart';

class SubCategoryController extends GetxController {
  var isloading = false.obs;
  var subTag = SubCategoryModel();
  String title = "";

  @override
  void onInit() {
    getData(Get.arguments[0], Get.arguments[1]);
  }

  void getData(int id, String categoryTitle) async {
    isloading.value = true;
    title = categoryTitle;
    var d = await ApiService.getSubCategory(id);
    subTag = d!;

    isloading.value = false;
  }
}
