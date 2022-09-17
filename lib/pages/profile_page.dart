import 'package:animate_do/animate_do.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nikan_app/controllers/profile_controller.dart';
import 'package:nikan_app/controllers/shop_cart_controller.dart';
import 'package:nikan_app/pages/edit_profile_page.dart';
import 'package:nikan_app/pages/saved_list_page.dart';
import 'package:nikan_app/pages/shop_cart_page.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:sizer/sizer.dart';
import '../services/limit_string.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getData();
    return Scaffold(
      drawer: _drawer(),
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        elevation: 3,
        centerTitle: true,
        title: Text(
          "profile".tr,
          style: PersianFonts.Vazir.copyWith(
              fontSize: 17.sp, fontWeight: FontWeight.w800),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _profile(),
            _summaryOfMySituation(),
            _orders(),
            _savedList(),
            _cart(),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
    );
  }

  _savedList() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
      padding: EdgeInsets.all(5.w),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30), //border corner radius
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
      child: Column(
        children: [
          Text(
            "saved".tr,
            style: PersianFonts.Vazir.copyWith(
                fontSize: 15.sp, fontWeight: FontWeight.w800),
          ),
          SizedBox(
            height: 2.h,
          ),
          Obx(() {
            if (controller.isloadingProfile.value) {
              return SpinKitHourGlass(
                color: Colors.teal,
              );
            }
            if (controller.saves!.length == 0) {
              print("No Item Found");
              return Text(
                "no_saved".tr,
                style: PersianFonts.Vazir.copyWith(
                    fontSize: 12.sp,
                    color: Colors.black45,
                    fontWeight: FontWeight.w800),
              );
            }
            return InkWell(
              onTap: () {
                Get.to(SavedListPage());
              },
              child: Text(
                "show_saved".tr + " (${controller.saves!.length})",
                style: PersianFonts.Vazir.copyWith(
                    fontSize: 12.sp,
                    color: Colors.black45,
                    fontWeight: FontWeight.w800),
              ),
            );
          }),
        ],
      ),
    );
  }

  _drawer() {
    return Obx(
      () {
        if (controller.isloadingSaves.value) {
          return Center(
            child: SpinKitCubeGrid(color: Colors.indigo),
          );
        }

        return Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  child: Text("R"),
                ),
                decoration: BoxDecoration(color: Colors.indigo),
                accountName: Text(
                  controller.userData!.fullName!,
                  style: PersianFonts.Vazir.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                accountEmail: Text(
                  controller.userData!.phone!,
                  style: PersianFonts.Vazir.copyWith(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Get.to(EditProfilePage());
                },
                //   leading: Icon(Icons.arrow_right_rounded),
                title: Text(
                  "edit_profile".tr,
                  style: PersianFonts.Vazir.copyWith(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Get.to(ShopCartPage());
                },
                //  leading: Icon(Icons.arrow_right_rounded),
                title: Text(
                  "cart".tr,
                  style: PersianFonts.Vazir.copyWith(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              ListTile(
                onTap: () {},
                //  leading: Icon(Icons.arrow_right_rounded),
                title: Text(
                  "orders".tr,
                  style: PersianFonts.Vazir.copyWith(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Get.to(SavedListPage());
                },
                //    leading: Icon(Icons.arrow_right_rounded),
                title: Text(
                  "save_like".tr,
                  style: PersianFonts.Vazir.copyWith(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  controller.exitAccount();
                },
                //   leading: Icon(Icons.arrow_right_rounded),
                title: Text(
                  "exit_from_account".tr,
                  style: PersianFonts.Vazir.copyWith(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _orders() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
      padding: EdgeInsets.all(5.w),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30), //border corner radius
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
      child: Column(
        children: [
          Text(
            "orders".tr,
            style: PersianFonts.Vazir.copyWith(
                fontSize: 15.sp, fontWeight: FontWeight.w800),
          ),
          SizedBox(
            height: 4.h,
          ),
          Obx(
            () {
              if (controller.isloadingProfile.value) {
                return SpinKitRotatingPlain(
                  color: Colors.amber,
                );
              }
              return Text(
                "no_orders".tr,
                style: PersianFonts.Vazir.copyWith(
                    fontSize: 12.sp,
                    color: Colors.black45,
                    fontWeight: FontWeight.w800),
              );

              return Text(
                "show_saved".tr,
                style: PersianFonts.Vazir.copyWith(
                    fontSize: 12.sp,
                    color: Colors.black45,
                    fontWeight: FontWeight.w800),
              );
            },
          ),
        ],
      ),
    );
  }

  _summaryOfMySituation() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
      padding: EdgeInsets.all(5.w),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30), //border corner radius
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "summary_of_my_situation".tr,
            style: PersianFonts.Vazir.copyWith(
                fontSize: 15.sp, fontWeight: FontWeight.w800),
          ),
          SizedBox(
            height: 4.h,
          ),
          Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                controller.isloadingProfile.value == false
                    ? Column(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/status-processing.svg",
                            color: Colors.yellow[700],
                            colorBlendMode: BlendMode.srcIn,
                            fit: BoxFit.cover,
                            placeholderBuilder: (context) => SizedBox(
                              width: 12.w,
                              height: 12.w,
                            ),
                            width: 12.w,
                            height: 12.w,
                            allowDrawingOutsideViewBox: true,
                          ),
                          SizedBox(
                            width: 2.h,
                          ),
                          Text(
                            "0 ".toPersianDigit() + "current_order".tr,
                            style: PersianFonts.Vazir.copyWith(
                                fontSize: 10.sp, fontWeight: FontWeight.w800),
                          ),
                        ],
                      )
                    : SpinKitFoldingCube(
                        color: Colors.yellow[700],
                      ),
                controller.isloadingProfile.value == false
                    ? Column(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/status-delivered.svg",
                            color: Colors.green[500],
                            colorBlendMode: BlendMode.srcIn,
                            fit: BoxFit.cover,
                            placeholderBuilder: (context) => SizedBox(
                              width: 12.w,
                              height: 12.w,
                            ),
                            width: 12.w,
                            height: 12.w,
                            allowDrawingOutsideViewBox: true,
                          ),
                          SizedBox(
                            width: 2.h,
                          ),
                          Text(
                            "0 ".toPersianDigit() + "delivered_order".tr,
                            style: PersianFonts.Vazir.copyWith(
                                fontSize: 10.sp, fontWeight: FontWeight.w800),
                          ),
                        ],
                      )
                    : SpinKitCircle(color: Colors.green[500]),
                controller.isloadingProfile.value == false
                    ? Column(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/status-returned.svg",
                            color: Colors.red,
                            colorBlendMode: BlendMode.srcIn,
                            fit: BoxFit.cover,
                            placeholderBuilder: (context) => SizedBox(
                              width: 12.w,
                              height: 12.w,
                            ),
                            width: 12.w,
                            height: 12.w,
                            allowDrawingOutsideViewBox: true,
                          ),
                          SizedBox(
                            width: 2.h,
                          ),
                          Text(
                            "0 ".toPersianDigit() + "returned_order".tr,
                            style: PersianFonts.Vazir.copyWith(
                                fontSize: 10.sp, fontWeight: FontWeight.w800),
                          ),
                        ],
                      )
                    : SpinKitRing(color: Colors.red)
              ],
            );
          })
        ],
      ),
    );
  }

  _profile() {
    return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
        padding: EdgeInsets.all(5.w),
        height: 30.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30), //border corner radius
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
        child: Obx(
          () {
            if (controller.isloadingProfile.value) {
              return SpinKitCubeGrid(
                color: Colors.cyan,
              );
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Get.to(EditProfilePage());
                  },
                  child: Icon(
                    Icons.edit_sharp,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    controller.userData!.avatar == "100"
                        ? CircleAvatar(
                            radius: 15.w,
                            child: Text(
                              controller.userData!.fullName!
                                  .substring(0, 1)
                                  .toUpperCase(),
                              style: PersianFonts.Vazir.copyWith(
                                  fontSize: 25.sp, fontWeight: FontWeight.w800),
                            ),
                          )
                        : CircleAvatar(
                            radius: 15.w,
                            backgroundImage: CachedNetworkImageProvider(
                                controller.userData!.avatar!),
                          ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      controller.userData!.fullName == "null"
                          ? "not_registered".tr
                          : controller.userData!.fullName!,
                      style: PersianFonts.Vazir.copyWith(
                          fontSize: 15.sp, fontWeight: FontWeight.w800),
                    ),
                    Text(
                      controller.userData!.phone == "null"
                          ? "not_registered".tr
                          : controller.userData!.phone!,
                      style: PersianFonts.Vazir.copyWith(
                          fontSize: 12.sp, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    controller.exitAccount();
                  },
                  child: Icon(
                    Icons.exit_to_app,
                  ),
                ),
              ],
            );
          },
        ));
  }

  _cart() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
      padding: EdgeInsets.all(5.w),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30), //border corner radius
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
      child: Column(
        children: [
          Text(
            "cart".tr,
            style: PersianFonts.Vazir.copyWith(
                fontSize: 15.sp, fontWeight: FontWeight.w800),
          ),
          SizedBox(
            height: 4.h,
          ),
          Obx(
            () {
              var c = Get.find<ShopCartController>();
              if (controller.isloadingProfile.value) {
                return SpinKitRotatingPlain(
                  color: Colors.amber,
                );
              }
              if (c.products.length == 0) {
                return Text(
                  "no_carts".tr,
                  style: PersianFonts.Vazir.copyWith(
                      fontSize: 12.sp,
                      color: Colors.black45,
                      fontWeight: FontWeight.w800),
                );
              }
              return InkWell(
                onTap: () {
                  Get.to(ShopCartPage());
                },
                child: Text(
                  "show_carts".tr + " (${c.products.length})".toPersianDigit(),
                  style: PersianFonts.Vazir.copyWith(
                      fontSize: 12.sp,
                      color: Colors.black45,
                      fontWeight: FontWeight.w800),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
