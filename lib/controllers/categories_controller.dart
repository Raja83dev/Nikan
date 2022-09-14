import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nikan_app/models/sub_category_model.dart';
import 'package:nikan_app/models/tag_model.dart';
import 'package:nikan_app/services/api_service.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:sizer/sizer.dart';

class CategoriesController extends GetxController {
  var isloadingTags = true.obs;
  var isloadingSubTags = false.obs;

  var tagList = <TagModel>[].obs;
  var subTag = SubCategoryModel();

  int selectedTagIndex = -1;

  void getTagList() async {
    isloadingTags.value = true;
    tagList.addAll(await ApiService.getCategories());
    isloadingTags.value = false;
  }

  @override
  void onInit() {
    getTagList();
  }

  void tagClicked(int index) async {
    
   
      isloadingSubTags.value=true;
     selectedTagIndex = index;
      var d = await ApiService.getSubCategory(tagList[index].id);
      subTag = d!;

      isloadingSubTags.value=false;
     
    
  }
}
