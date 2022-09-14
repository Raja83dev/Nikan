import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:nikan_app/pages/sub_categories_page.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:nikan_app/controllers/categories_controller.dart';
import 'package:sizer/sizer.dart';
import 'package:auto_animated/auto_animated.dart';

class CategoriesPage extends GetView<CategoriesController> {
  CategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        centerTitle: true,
        title: AutoSizeText(
          "tags".tr,
          maxLines: 1,
          style: PersianFonts.Yekan.copyWith(
            fontSize: 15.sp,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isloadingTags.value == true) {
          return Center(
            child: SpinKitFoldingCube(
              size: 10.w,
              color: Colors.indigo,
            ),
          );
        }
        return LiveGrid(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 5.h),
          delay: Duration(milliseconds: 100),
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: controller.tagList.length,
          itemBuilder:
              (BuildContext context, int index, Animation<double> animation) {
            return FadeTransition(
              opacity: Tween<double>(
                begin: 0,
                end: 1,
              ).animate(animation),
              child: InkWell(
                borderRadius: BorderRadius.circular(5.w),
                onTap: () {
                  controller.tagClicked(index);
                  Get.to(SubCategoriesPage());
                },
                child: Padding(
                  padding: EdgeInsets.all(3.w),
                  child: Material(
                    borderRadius: BorderRadius.circular(5.w),
                    elevation: 3,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 2,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5.w),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: controller.tagList[index].image,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: AutoSizeText(
                              controller.tagList[index].name,
                              maxLines: 1,
                              style: PersianFonts.Yekan.copyWith(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w800,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
