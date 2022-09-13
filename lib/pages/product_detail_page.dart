import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_switch_clipper/flutter_switch_clipper.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:nikan_app/pages/shop_cart_page.dart';
import 'package:nikan_app/services/api_service.dart';
import 'package:nikan_app/widgets/comment_widget.dart';
import 'package:nikan_app/widgets/product_button.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:nikan_app/controllers/product_detail_controller.dart';
import 'package:shimmer/shimmer.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:sizer/sizer.dart';
import 'package:nikan_app/services/limit_string.dart';
import 'package:nikan_app/models/product_detail_model.dart';

import '../widgets/limited_text.dart';

class ProductDetailPage extends GetView<ProductDetailController> {
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    controller.getDetail(int.parse(Get.arguments));

    return Obx(() {
      if (controller.isLoading.value) {
        return Scaffold(
          body: Center(
            child: SpinKitDancingSquare(color: Colors.indigo[800], size: 10.w),
          ),
        );
      }
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 2,
          backgroundColor: Colors.indigo,
          centerTitle: true,
          title: Container(
            width: double.infinity,
            child: Text(
              controller.productDetail!.title!.limited(26),
              style: PersianFonts.Yekan.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w200,
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.to(ShopCatPage());
              },
              icon: Icon(
                Icons.shopping_cart_outlined,
              ),
            ),
          ],
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _topSlider(),
                  SizedBox(
                    height: 2.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: Column(
                      children: [
                        _categoryTitle(),
                        Divider(),
                        AutoSizeText(
                          controller.productDetail!.title!,
                          maxLines: 4,
                          style: PersianFonts.Yekan.copyWith(
                            height: 1.5,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w800,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        _selectSize(),
                        Divider(),
                        SizedBox(
                          height: 3.h,
                        ),
                        HtmlWidget(
                          controller.productDetail!.des!,
                          textStyle: PersianFonts.Yekan.copyWith(
                            fontSize: 13.sp,
                            color: Colors.black45,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Divider(),
                        _details(),
                        Divider(),
                        SizedBox(
                          height: 3.h,
                        ),
                        _commentsBody(),
                        SizedBox(
                          height: 3.h,
                        ),
                        _related(),
                        SizedBox(
                          height: 20.h,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _buttonWidget(),
          ],
        ),
      );
    });
  }

  Widget _topSlider() {
    return CarouselSlider(
        items:
            List.generate(controller.productDetail!.gallery!.length, (index) {
          return Container(
            width: 90.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.w),
              image: DecorationImage(
                fit: BoxFit.fitHeight,
                image: CachedNetworkImageProvider(
                  controller.productDetail!.gallery![index].imgUrl!,
                ),
              ),
            ),
          );
        }),
        options: CarouselOptions(
          height: 40.h,
          aspectRatio: 16 / 9,
          viewportFraction: 1,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 5),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        ));

    return CachedNetworkImage(
      imageUrl: controller.productDetail!.image!,
      fit: BoxFit.fitWidth,
    );
  }

  Widget _commentsBody() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AutoSizeText(
              "comments".tr,
              style: PersianFonts.Yekan.copyWith(
                height: 1.5,
                fontSize: 15.sp,
                fontWeight: FontWeight.w800,
                color: Colors.black54,
              ),
            ),
            controller.productDetail!.commentCount! > 0
                ? CupertinoButton(
                    onPressed: () {
                      Get.bottomSheet(
                        Scaffold(
                          appBar: AppBar(
                            backgroundColor: Colors.indigo,
                            title: Text(
                              "comments".tr,
                              style: PersianFonts.Yekan.copyWith(
                                height: 1.5,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          body: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3.w),
                            child: SingleChildScrollView(
                              child: Column(
                                children: List.generate(
                                    controller.productDetail!.commentCount!,
                                    (index) {
                                  return CommentWidget(
                                      commentModel: controller
                                          .productDetail!.comment![index]);
                                }),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    child: AutoSizeText(
                      controller.productDetail!.commentCount!.toString() +
                          "comment".tr,
                      style: PersianFonts.Yekan.copyWith(
                        height: 1.5,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w800,
                        color: Colors.black45,
                      ),
                    ),
                  )
                : SizedBox(),
          ],
        ),
        SizedBox(
          height: 3.h,
        ),
        controller.productDetail!.commentCount! == 0
            ? AutoSizeText(
                "no_comment_for_product".tr,
                style: PersianFonts.Yekan.copyWith(
                  height: 1.5,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w800,
                  color: Colors.black45,
                ),
              )
            : Column(
                children: List.generate(
                    controller.productDetail!.commentCount! >= 3
                        ? 3
                        : controller.productDetail!.commentCount!, (index) {
                  return CommentWidget(
                      commentModel: controller.productDetail!.comment![index]);
                }),
              ),
      ],
    );
  }

  Widget _categoryTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AutoSizeText(
          controller.productDetail!.category! +
              " / " +
              controller.productDetail!.subCategory! +
              " / " +
              controller.productDetail!.childCategory!,
          maxLines: 1,
          style: PersianFonts.Yekan.copyWith(
            height: 1.5,
            fontSize: 10.sp,
            fontWeight: FontWeight.w800,
            color: Colors.blue[700],
          ),
        ),
        Row(
          children: [
            AutoSizeText(
              controller.productDetail!.avrage!,
              maxLines: 1,
              style: PersianFonts.Yekan.copyWith(
                height: 1.5,
                fontSize: 10.sp,
                fontWeight: FontWeight.w800,
                color: Colors.yellow[700],
              ),
            ),
            Icon(
              Icons.star,
              color: Colors.yellow[800],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buttonWidget() {
    return Positioned(
      bottom: 0,
      child: Container(
        width: 100.w,
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5.w),
            topRight: Radius.circular(5.w),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), //shadow color
              spreadRadius: 5, // spread radius
              blurRadius: 7, // shadow blur radius
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(
              controller.productDetail!.stock!.toString() +
                  " " +
                  "numbers_in_store".tr,
              maxLines: 1,
              style: PersianFonts.Yekan.copyWith(
                height: 1.5,
                fontSize: 12.sp,
                fontWeight: FontWeight.w800,
                color: Colors.red[700],
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Row(
              children: [
                Expanded(
                  child: Obx(() {
                    print("Cart Value : " + controller.productDetail!.inCart!);
                    if (controller.isSending.value) {
                      return Center(
                        child: SpinKitFoldingCube(
                          color: Colors.indigo,
                        ),
                      );
                    }

                    if (controller.productDetail!.inCart == "200") {
                      return ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                          elevation: MaterialStateProperty.all(0),
                        ),
                        onPressed: controller.removeFromCart,
                        child: Text(
                          "remove_from_cart".tr,
                          style: PersianFonts.Yekan.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      );
                    }

                    return ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.indigo)),
                      onPressed: controller.addToCart,
                      child: Text(
                        "add_to_cart".tr,
                        style: PersianFonts.Yekan.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    );
                  }),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AutoSizeText(
                      controller.productDetail!.price!.seRagham() + "toman".tr,
                      maxLines: 1,
                      style: PersianFonts.Yekan.copyWith(
                        height: 1.5,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w800,
                        color: Colors.green[700],
                      ),
                    ),
                    SizedBox(
                      width: 2.h,
                    ),
                    AutoSizeText(
                      controller.productDetail!.delPrice!.seRagham(),
                      maxLines: 1,
                      style: PersianFonts.Yekan.copyWith(
                        decoration: TextDecoration.lineThrough,
                        height: 1.5,
                        fontSize: 8.sp,
                        fontWeight: FontWeight.w800,
                        color: Colors.red[700],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _selectSize() {
    if (controller.productDetail!.size!.length == 0) {
      return SizedBox();
    }
    return SizedBox(
      width: 90.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            "select_size".tr,
            maxLines: 4,
            style: PersianFonts.Yekan.copyWith(
              height: 1.5,
              fontSize: 16.sp,
              fontWeight: FontWeight.w800,
              color: Colors.black54,
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:
                List.generate(controller.productDetail!.size!.length, (index) {
              return InkWell(
                onTap: () {
                  controller.selectedSizeIndex.value = index;
                },
                child: SwitchCipper(
                  isSelect: controller.selectedSizeIndex.value == index,
                  initSelect: controller.selectedSizeIndex.value == index,
                  background: Container(
                    color: Colors.white,
                    alignment: Alignment.center,
                    padding:
                        EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.h),
                    child: AutoSizeText(
                      controller.productDetail!.size![index].value!,
                      style: PersianFonts.Yekan.copyWith(
                        fontSize: 13.sp,
                        color: Colors.black54,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    padding:
                        EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.h),
                    decoration: BoxDecoration(
                      color: Colors.indigo.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(5.w),
                    ),
                    child: AutoSizeText(
                      controller.productDetail!.size![index].value!,
                      style: PersianFonts.Yekan.copyWith(
                        fontSize: 13.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _details() {
    if (controller.productDetail!.details!.length == 0) {
      return SizedBox();
    }
    return SizedBox(
      width: 90.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            "attributes".tr,
            maxLines: 4,
            style: PersianFonts.Yekan.copyWith(
              height: 1.5,
              fontSize: 16.sp,
              fontWeight: FontWeight.w800,
              color: Colors.black54,
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(controller.productDetail!.details!.length,
                (index) {
              return AutoSizeText(
                controller.productDetail!.details![index].title! +
                    " : " +
                    controller.productDetail!.details![index].value!,
                maxLines: 4,
                style: PersianFonts.Yekan.copyWith(
                  height: 1.5,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w800,
                  color: Colors.black54,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _related() {
    return SizedBox(
      width: 90.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            "related_products".tr,
            maxLines: 4,
            style: PersianFonts.Yekan.copyWith(
              height: 1.5,
              fontSize: 16.sp,
              fontWeight: FontWeight.w800,
              color: Colors.black54,
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(controller.productDetail!.related!.length,
                  (index) {
                return InkWell(
                  onTap: () {
                    controller.getDetail(
                        controller.productDetail!.related![index].id!);
                    controller.selectedSizeIndex.value = 0;
                  },
                  child: Padding(
                    padding: EdgeInsets.all(2.w),
                    child: Material(
                      elevation: 4,
                      child: Container(
                        padding: EdgeInsets.all(2.w),
                        width: 40.w,
                        height: 60.w,
                        child: Column(
                          children: [
                            controller.productDetail!.related![index].image!
                                        .length >
                                    7
                                ? SizedBox(
                                    height: 40.w,
                                    width: 40.w,
                                    child: CachedNetworkImage(
                                      imageUrl: controller.productDetail!
                                          .related![index].image!,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Container(
                                    child: Center(
                                      child: Text(
                                        "no_image".tr,
                                        style: PersianFonts.Vazir.copyWith(
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                    height: 40.w,
                                    width: 40.w,
                                  ),
                            Expanded(
                              child: Row(
                                children: [
                                  LimitedText(
                                    text: controller
                                        .productDetail!.related![index].title!,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black45,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    controller
                                        .productDetail!.related![index].price!,
                                    style: PersianFonts.Vazir.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black45,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
