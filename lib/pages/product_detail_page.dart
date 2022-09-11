import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:nikan_app/widgets/comment_widget.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:nikan_app/controllers/product_detail_controller.dart';
import 'package:shimmer/shimmer.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:sizer/sizer.dart';
import 'package:nikan_app/services/limit_string.dart';
import 'package:nikan_app/models/product_detail_model.dart';

class ProductDetailPage extends GetView<ProductDetailController> {
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getDetail(Get.arguments);
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
                          height: 2.h,
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
                        SizedBox(
                          height: 3.h,
                        ),
                        _commentsBody(),
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
              "دیدگاه کاربران ",
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
                              "دیدگاه کاربران",
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
                          " دیدگاه",
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
                "دیدگاهی برای این محصول ثبت نشده",
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
              controller.productDetail!.stock!.toString() + " عدد در انبار",
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
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.indigo)),
                    onPressed: () {},
                    child: Text(
                      "افزودن به سبد خرید",
                      style: PersianFonts.Yekan.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AutoSizeText(
                      controller.productDetail!.price!.seRagham() + "  تومان",
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
}
