import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
           
        SliverToBoxAdapter(
          child: SizedBox(
            height: 20.h,
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            width: 20.w,
            height: 20.w,
            child: Image.asset(
              "assets/icons/nikan_logo.png",
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
        SliverAppBar(
          backgroundColor: Colors.white,
          elevation: 3,
          centerTitle: true,
          pinned: true,
          title: Material(
            elevation: 3,
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.w),
            child: Container(
              //margin: EdgeInsets.symmetric(horizontal: 5.w),
              width: 90.w,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.15),
                borderRadius: BorderRadius.circular(4.w),
              ),
              child: TextField(
                readOnly: true,
                onTap: () {
                  Get.to(() => SearchPage());
                },
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search_outlined,
                    color: Colors.indigo,
                  ),
                  suffixIcon: Icon(
                    Icons.check_outlined,
                    color: Colors.indigo,
                  ),
                  border: InputBorder.none,
                  hintText: "search".tr,
                  hintStyle: PersianFonts.Yekan.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black45,
                  ),
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 4.h,
              ),
              Obx(() {
                if (controller.isloadingSlider.value) {
                  return SizedBox(
                    width: 90.w,
                    height: 40.h,
                  );
                }
                return CarouselSlider(
                    items: List.generate(controller.sliderList.length, (index) {
                      return Container(
                        width: 90.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.w),
                          image: DecorationImage(
                            fit: BoxFit.fitHeight,
                            image: CachedNetworkImageProvider(
                              controller.sliderList[index].image,
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
                      autoPlayInterval: Duration(seconds: 6),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                    ));
              }),

              SizedBox(
                height: 2.h,
              ),
              // Obx(() {
              //   if(controller.isloadingTags.value){
              //     return SizedBox(height: 30.h,width:90.w);
              //   }
              //   return SingleChildScrollView(
              //     scrollDirection: Axis.horizontal,
              //     child: Row(
              //       children: List.generate(controller.tagList.length, (index) {
              //         return Padding(
              //           padding: EdgeInsets.symmetric(horizontal: 1.w / 2),
              //           child: SwitchCipper(
              //             child: Container(
              //               color: Colors.white,
              //               alignment: Alignment.center,
              //               padding: EdgeInsets.symmetric(
              //                   vertical: 1.h, horizontal: 2.h),
              //               child: LimitedText(
              //                 text: controller.tagList[index].name,
              //                 color: Colors.indigo.withOpacity(0.8),
              //                 fontSize: 10.sp,
              //               ),
              //             ),
              //             background: Container(
              //               alignment: Alignment.center,
              //               padding: EdgeInsets.symmetric(
              //                   vertical: 1.h, horizontal: 2.h),
              //               decoration: BoxDecoration(
              //                 color: Colors.indigo.withOpacity(0.8),
              //                 borderRadius: BorderRadius.circular(5.w),
              //               ),
              //               child: LimitedText(
              //                   text: controller.tagList[index].name,
              //                   fontSize: 10.sp),
              //             ),
              //           ),
              //         );
              //       }),
              //     ),
              //   );
              // }),
              SizedBox(
                height: 2.h,
              ),
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
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                                controller.productList[i].product!.length,
                                (index) {
                              return ProductButton(
                                id: controller
                                    .productList[i].product![index].id,
                                name: controller
                                    .productList[i].product![index].title!,
                                image: controller
                                    .productList[i].product![index].image!,
                                price: controller
                                    .productList[i].product![index].price!
                                    .seRagham()
                                    .toPersianDigit(),
                              );
                            }),
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
