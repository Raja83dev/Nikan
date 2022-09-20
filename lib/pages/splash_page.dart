import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nikan_app/constans.dart';
import 'package:nikan_app/pages/login_page.dart';
import 'package:nikan_app/pages/main_page.dart';
import 'package:nikan_app/services/api_service.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          "assets/lottie/splash/19902-splash-screen.json",
          alignment: Alignment.center,
          
          fit: BoxFit.fitWidth,
          width: 100.w,
          
          height: 100.h,
          onLoaded: (compose) async {
               var data = await ApiService.loginWithToken();
                await Future.delayed(Duration(seconds: 2));
                print("Data Is OK : $data");
                if (data == true) {
                  Get.offAll(MainPage());
                } else {
                  Get.offAll(LoginPage());
                }
          }
        ),
      ),
    );
  }
}
