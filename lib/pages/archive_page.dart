import 'package:auto_animated/auto_animated.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:nikan_app/constans.dart';
import 'package:nikan_app/controllers/archive_controller.dart';
import 'package:nikan_app/models/product_detail_model.dart';
import 'package:nikan_app/pages/product_detail_page.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:sizer/sizer.dart';

class ArchivePage extends GetView<ArchiveController> {
  const ArchivePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: accentColor,
        centerTitle: true,
        title: Obx(() {
          if (controller.isloading.value) {
            return SizedBox();
          }
          return AutoSizeText(
            controller.title,
            maxLines: 1,
            style: PersianFonts.Yekan.copyWith(
              fontSize: 15.sp,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          );
        }),
      ),
      body: Obx(() {
        if (controller.isloading.value) {
          return Center(
            child: SpinKitChasingDots(color: accentColor),
          );
        }
        if (controller.productModels.length == 0) {
          return Center(
            child: Text(
              "not_found_product".tr,
              style: PersianFonts.Vazir.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.w800,
                color: Colors.black45,
              ),
            ),
          );
        }
        return LiveGrid(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 5.h),
          delay: Duration(milliseconds: 100),
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: controller.productModels.length,
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
                  Get.to(ProductDetailPage(),
                      arguments: controller.productModels[index].id);
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
                              imageUrl: controller.productModels[index].image!,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: AutoSizeText(
                              controller.productModels[index].title!,
                              maxLines: 1,
                              textAlign: TextAlign.center,
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
