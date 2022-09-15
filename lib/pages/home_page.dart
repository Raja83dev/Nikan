import 'package:auto_animated/auto_animated.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:nikan_app/controllers/main_controller.dart';
import 'package:nikan_app/pages/search_page.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:nikan_app/controllers/home_controller.dart';
import 'package:nikan_app/widgets/product_button.dart';
import 'package:sizer/sizer.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      scrollDirection: Axis.vertical,
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.indigo,
          elevation: 3,
          centerTitle: true,
          pinned: true,
          leadingWidth: 20.w,
          actions: [
            ShaderMask(
blendMode: BlendMode.clear,
                shaderCallback: (Rect bounds) {
                  return LinearGradient(colors: [Colors.white,Colors.white])
                      .createShader(bounds);
                },
                child: Image.asset(
                  "assets/icons/nikan_logo.png",
                  fit: BoxFit.fill,
                ),),
          ],
          leading: InkWell(
            onTap: () {},
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(right: 3.w),
                child: Text(
                  "cart".tr,
                  style: PersianFonts.Yekan.copyWith(
                      fontSize: 11.sp, fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ),
          title: Text(
            "nikan".tr,
            style: PersianFonts.Yekan.copyWith(
                fontSize: 17.sp, fontWeight: FontWeight.w800),
          ),
        ),
        SliverToBoxAdapter(
          child: Obx(() {
            if (controller.isloadingTags.value) {
              return Padding(
                padding: EdgeInsets.only(top: 3.h),
                child: SpinKitPouringHourGlass(
                  color: Colors.indigo,
                ),
              );
            }

            return SizedBox(
              height: 10.h,
              child: LiveList(
                scrollDirection: Axis.horizontal,
                itemCount: controller.tagList.length,
                itemBuilder: (BuildContext context, int index,
                    Animation<double> animation) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset(0, -1),
                      end: Offset(0, 0),
                    ).animate(animation),
                    child: index == 0
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3.w),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.search),
                            ),
                          )
                        : CupertinoButton(
                            onPressed: () {},
                            child: AutoSizeText(
                              controller.tagList[index].name,
                              maxLines: 1,
                              style: PersianFonts.Yekan.copyWith(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                  );
                },
              ),
            );
          }),
        ),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                if (controller.isloadingProduct.value) {
                  return SizedBox();
                }
                return Column(
                    children: List.generate(controller.productList.length, (i) {
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              controller.productList[i].name!,
                              style: PersianFonts.Yekan.copyWith(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black54),
                            ),
                            CupertinoButton(
                              child: Text(
                                "show_all".tr,
                                style: PersianFonts.Yekan.copyWith(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w800),
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        SizedBox(
                          height: 30.h,
                          child: controller.productList[i].product!.length == 0
                              ? Center(
                                  child: Text(
                                    "not_product_in_brand".tr,
                                    style: PersianFonts.Yekan.copyWith(
                                        fontSize: 17.sp,
                                        color: Colors.black45,
                                        fontWeight: FontWeight.w800),
                                  ),
                                )
                              : LiveList(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index, animation) {
                                    return SlideTransition(
                                      position: Tween<Offset>(
                                        begin: Offset(0, -1),
                                        end: Offset(0, 0),
                                      ).animate(animation),
                                      child: ProductButton(
                                        id: controller
                                            .productList[i].product![index].id,
                                        name: controller.productList[i]
                                            .product![index].title!,
                                        image: controller.productList[i]
                                            .product![index].image!,
                                        price: controller.productList[i]
                                            .product![index].price!
                                            .seRagham()
                                            .toPersianDigit(),
                                      ),
                                    );
                                  },
                                  itemCount:
                                      controller.productList[i].product!.length,
                                ),
                        ),
                      ],
                    ),
                  );
                }));
              }),
            ],
          ),
        ),
      ],
    );
  }
}
