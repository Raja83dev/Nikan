import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:nikan_app/controllers/search_controller.dart';
import 'package:nikan_app/widgets/limited_text.dart';
import 'package:sizer/sizer.dart';

class SearchPage extends GetView<SearchController> {
  SearchPage({Key? key}) : super(key: key);

  FocusNode seachNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    seachNode.requestFocus();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 5.h,
            ),
            Obx(() {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 5.w),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4.w),
                ),
                child: TextField(
                  onChanged: controller.getSearchedProducts,
                  focusNode: seachNode,
                  onTap: () {},
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search_outlined,
                      color: Colors.indigo[700],
                    ),
                    suffixIcon: controller.isloading.value
                        ? SizedBox(
                            width: 8.w,
                            child: SpinKitWanderingCubes(
                              size: 8.w,
                              color: Colors.indigo,
                            ),
                          )
                        : Icon(
                            Icons.check_outlined,
                            color: Colors.indigo[700],
                          ),
                    border: InputBorder.none,
                    labelText: "search".tr,
                    labelStyle: PersianFonts.Yekan,
                  ),
                ),
              );
            }),
            SizedBox(
              height: 3.h,
            ),
            Obx(() {
              if (controller.isloading.value) {
                return SizedBox();
              }
              return Container(
                width: 100.w,
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                      controller.products.length,
                      (index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h/2),
                          child: Material(
                            borderRadius: BorderRadius.circular(5.w),
                            elevation: 2,
                            child: Container(
                              width: 95.w,
                              height: 15.h,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 15.h,
                                          height: 15.h,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5.w),
                                            child: CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              imageUrl: controller
                                                  .products[index].image!,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 1.h, horizontal: 1.w),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                AutoSizeText(
                                                  controller
                                                      .products[index].title!,
                                                  style: PersianFonts.Yekan
                                                      .copyWith(
                                                          color: Colors.black54,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    AutoSizeText(
                                                      controller.products[index]
                                                              .price!
                                                              .seRagham()
                                                              .toPersianDigit() +
                                                          "toman".tr,
                                                      style: PersianFonts.Yekan
                                                          .copyWith(
                                                              color: Colors.green[600],
                                                              fontWeight:
                                                                  FontWeight.w700,
                                                              fontSize: 13.sp),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        // LimitedText(text: controller.products[index].title!, fontSize:10.sp,color: Colors.black45,),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            }),
            SizedBox(
              height: 4.h,
            ),
          ],
        ),
      ),
    );
  }
}
