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

  void getTagList() async {
    isloadingTags.value = true;
    tagList.addAll(await ApiService.getCategories());
    isloadingTags.value = false;
  }

  @override
  void onInit() {
    getTagList();
  }

  void tagClicked(int id) async {
    
    if (isloadingSubTags.value == false) {
      isloadingSubTags.value=true;
     
      var d = await ApiService.getSubCategory(id);
      subTag = d!;

      Get.bottomSheet(
        Container(
          color: Colors.white,
          width: 100.w,
          height: 80.h,
          child: SingleChildScrollView(
            child: Column(
              children: List.generate(subTag.items!.length, (index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 1.h / 5),
                  child: Material(
                    elevation: 1,
                    child: ListTile(
                      onTap: () {},
                      trailing: Icon(Icons.chevron_right_outlined),
                      title: Text(
                        subTag.items![index].title!,
                        style: PersianFonts.Vazir.copyWith(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      );
      isloadingSubTags.value=false;
     
    }
  }
}
