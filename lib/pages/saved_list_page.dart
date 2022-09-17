import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:nikan_app/controllers/profile_controller.dart';
import 'package:nikan_app/pages/product_detail_page.dart';

import 'package:persian_fonts/persian_fonts.dart';
import 'package:sizer/sizer.dart';

class SavedListPage extends GetView<ProfileController> {
  const SavedListPage({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getSaves();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        elevation: 3,
        centerTitle: true,
        title: Text(
          "saved".tr,
          style: PersianFonts.Vazir.copyWith(
              fontSize: 17.sp, fontWeight: FontWeight.w800),
        ),
      ),
      body: Obx(() {
        if (controller.isloadingSaves.value) {
          return Center(
            child: SpinKitFadingCircle(color: Colors.indigo),
          );
        }

        if (controller.saves!.length == 0) {
          return Text(
            "no".tr,
            style: PersianFonts.Vazir.copyWith(
                fontSize: 20.sp, fontWeight: FontWeight.w800),
          );
        }
        return SingleChildScrollView(
          child: Column(
            children: List.generate(controller.saves!.length, (index) {
              return InkWell(
                onTap: () {
                  Get.to(ProductDetailPage(),
                      arguments: controller.saves![index].id.toString());
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                  padding: EdgeInsets.all(5.w),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(30), //border corner radius
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2), //color of shadow
                        spreadRadius: 1, //spread radius
                        blurRadius: 7, // blur radius
                        offset: Offset(0, 1), // changes position of shadow
                        //first paramerter of offset is left-right
                        //second parameter is top to down
                      ),
                      //you can set more BoxShadow() here
                    ],
                  ),
                  child: CachedNetworkImage(
                    imageUrl: controller.saves![index].image!,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              );
            }),
          ),
        );
      }),
    );
  }
}
