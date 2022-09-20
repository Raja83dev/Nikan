import 'package:auto_animated/auto_animated.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nikan_app/constans.dart';
import 'package:nikan_app/controllers/main_controller.dart';
import 'package:nikan_app/pages/search_page.dart';
import 'package:nikan_app/pages/shop_cart_page.dart';
import 'package:nikan_app/pages/sub_categories_page.dart';
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
          shadowColor: accentColor,
          backgroundColor: Colors.white,
          elevation: 5,
          centerTitle: true,
          pinned: true,
          leadingWidth: 20.w,
          leading: InkWell(
            onTap: () {
              Get.to(ShopCartPage());
            },
            child: Icon(
              Icons.shopping_cart_outlined,
              color: accentColor,
            ),
          ),
          title: Image.asset(
            "assets/icons/nikan_logo.png",
            height: 5.h,
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 3.w,
            ),
            child: Obx(() {
              if (controller.isloadingSlider.value) {
                return Lottie.asset(
                    "assets/lottie/splash/19902-splash-screen.json");
              }
              return CarouselSlider(
                items: List.generate(controller.sliderList.length, (index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(5.w),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      placeholder: (context, url) {
                        return Lottie.asset(
                            "assets/lottie/splash/19902-splash-screen.json");
                      },
                      errorWidget: (context, url, error) {
                        print("Error Of Slider Not Image Load");
                        return SizedBox();
                      },
                      imageUrl: controller.sliderList[index].image,
                    ),
                  );
                }),
                options: CarouselOptions(
                  height: 30.h,
                  aspectRatio: 16 / 9,
                  viewportFraction: 1,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
              );
            }),
          ),
        ),
        SliverToBoxAdapter(
          child: Obx(() {
            if (controller.isloadingTags.value) {
              return Center(
                child: SpinKitPouringHourGlass(
                  color: Colors.indigo,
                ),
              );
            }

            return SizedBox(
              height: 16.h,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "tags".tr,
                      style: PersianFonts.Vazir.copyWith(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black54,
                      ),
                    ),
                    Expanded(
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
                            child: CupertinoButton(
                              onPressed: () {
                                Get.to(SubCategoriesPage(), arguments: [
                                  controller.tagList[index].id,
                                  controller.tagList[index].name
                                ]);
                              },
                              child: AutoSizeText(
                                controller.tagList[index].name,
                                maxLines: 1,
                                style: PersianFonts.Vazir.copyWith(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
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
                        Text(
                          "best_products_of".tr +
                              controller.productList[i].name!,
                          style: PersianFonts.Vazir.copyWith(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.black54),
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
                                    style: PersianFonts.Vazir.copyWith(
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
