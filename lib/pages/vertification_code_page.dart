import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nikan_app/widgets/main_button.dart';
import 'package:sizer/sizer.dart';

import '../widgets/dont_have_account_button.dart';

class VertificationCodePage extends StatelessWidget {
  const VertificationCodePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: 80.w,
                height: 30.h,
                child: Image.asset(
                  "assets/icons/nikan_logo.png",
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 6.h,
              ),
              SizedBox(
                width: 90.w,
                child: Text(
                  "verify_code".tr,
                  style: TextStyle(
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w900,
                    color: Colors.black54,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(4.w),
                child: Text(
                  "login_body_text".tr,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
                width: 90.w,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 15.w,
                      height: 15.w,
                      color: Colors.grey[200],
                    ),
                    Container(
                      width: 15.w,
                      height: 15.w,
                      color: Colors.grey[200],
                    ),
                    Container(
                      width: 15.w,
                      height: 15.w,
                      color: Colors.grey[200],
                    ),
                    Container(
                      width: 15.w,
                      height: 15.w,
                      color: Colors.grey[200],
                    ),
                  ],
                ),
              ),
              MainButton(text: "next".tr, clicked: () {}),
              SizedBox(
                height: 3.h,
              ),
              DontHaveAccountButton(
                text: "dont_have_account".tr,
                btnText: "sign_up".tr,
                clicked: () {
                  Get.offNamed("/signup");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
