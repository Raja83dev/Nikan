import 'package:get/get.dart';
import 'package:nikan_app/models/tag_model.dart';
import 'package:nikan_app/services/api_service.dart';

class CategoriesController extends GetxController{

   var isloadingTags = true.obs;

  var tagList = <TagModel>[].obs;

  
   void getTagList() async {
    isloadingTags.value = true;
    tagList.addAll(await ApiService.getCategories());
    isloadingTags.value = false;
  }


  @override
  void onInit() {
     getTagList();
     
  }
}