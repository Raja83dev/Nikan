import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:nikan_app/controllers/categories_controller.dart';
import 'package:sizer/sizer.dart';
import 'package:auto_animated/auto_animated.dart';

class SubCategoriesPage extends GetView<CategoriesController> {
  SubCategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Colors.indigo,
        centerTitle: true,
        title: AutoSizeText(
          controller.tagList[controller.selectedTagIndex].name,
          maxLines: 1,
          style: PersianFonts.Yekan.copyWith(
            fontSize: 15.sp,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isloadingSubTags.value == true) {
          return Center(
            child: SpinKitFoldingCube(
              size: 10.w,
              color: Colors.indigo,
            ),
          );
        }
        return LiveList(
          separatorBuilder: (context, index) {
            return Divider(indent: 5.h,);
          },
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 5.h),
          delay: Duration(milliseconds: 800),
          itemCount: controller.subTag.items!.length,
          itemBuilder:
              (BuildContext context, int index, Animation<double> animation) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: Offset(-1, 0),
                end: Offset(0, 0),
              ).animate(animation),
              child: ListTile(
                onTap: (){},
                
                title: AutoSizeText(
                  controller.subTag.items![index].title!,
                  maxLines: 1,
                  style: PersianFonts.Yekan.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                    color: Colors.black54,
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