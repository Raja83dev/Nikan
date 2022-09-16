import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nikan_app/controllers/profile_controller.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:sizer/sizer.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
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
            height: 4.h,
          ),
          Obx(
            () {
              return controller.isloadingSaves.value == false
                  ? Text(
                      "no_saved".tr,
                      style: PersianFonts.Vazir.copyWith(
                          fontSize: 12.sp,
                          color: Colors.black45,
                          fontWeight: FontWeight.w800),
                    )
                  : SpinKitHourGlass(
                      color: Colors.teal,
                    );
            },
          ),
        ],
      ),
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
              return controller.isloadingOrders.value == false
                  ? Text(
                      "no_orders".tr,
                      style: PersianFonts.Vazir.copyWith(
                          fontSize: 12.sp,
                          color: Colors.black45,
                          fontWeight: FontWeight.w800),
                    )
                  : SpinKitRotatingPlain(
                      color: Colors.amber,
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
                controller.isloadingCurrentOrder.value == false
                    ? Column(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/status-processing.svg",
                            color: Colors.yellow[700],
                            colorBlendMode: BlendMode.srcIn,
                            width: 12.w,
                            height: 12.w,
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
                controller.isloadingDeliveredOrder.value == false
                    ? Column(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/status-delivered.svg",
                            color: Colors.green[500],
                            colorBlendMode: BlendMode.srcIn,
                            width: 12.w,
                            height: 12.w,
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
                controller.isloadingReturnedOrder.value == false
                    ? Column(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/status-returned.svg",
                            color: Colors.red,
                            colorBlendMode: BlendMode.srcIn,
                            width: 12.w,
                            height: 12.w,
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
                  onTap: () {},
                  child: Icon(
                    Icons.edit_sharp,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(radius: 15.w),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      "علی قربانی",
                      style: PersianFonts.Vazir.copyWith(
                          fontSize: 15.sp, fontWeight: FontWeight.w800),
                    ),
                    Text(
                      "09025761246".toPersianDigit(),
                      style: PersianFonts.Vazir.copyWith(
                          fontSize: 12.sp, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {},
                  child: Icon(
                    Icons.exit_to_app,
                  ),
                ),
              ],
            );
          },
        ));
  }
}
