import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:nikan_app/controllers/splash_controller.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.checkLogin();
    return Scaffold(
      backgroundColor: Colors.indigo[400],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "nikan".tr,
                style: PersianFonts.Yekan.copyWith(
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w900,
                    color: Colors.white),
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                "لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با ",
                textAlign: TextAlign.center,
                style: PersianFonts.Yekan.copyWith(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w900,
                  color: Colors.indigo[100],
                ),
              ),
            ],
          ),
          SpinKitChasingDots(
            size: 10.w,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
