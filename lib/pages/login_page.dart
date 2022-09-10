import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:nikan_app/controllers/login_controller.dart';
import 'package:nikan_app/widgets/customized_text_field.dart';
import 'package:nikan_app/widgets/dont_have_account_button.dart';
import 'package:nikan_app/widgets/limited_text.dart';
import 'package:nikan_app/widgets/main_button.dart';
import 'package:sizer/sizer.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {

    controller.phone.text = "";
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 4.h,
              ),
              SizedBox(
                width: 80.w,
                height: 30.h,
                child: Image.asset(
                  "assets/icons/nikan_logo.png",
                  fit: BoxFit.cover,
                ),
              ),
              Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(5.w),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                  width: 90.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 80.w,
                        child: Text(
                          "login".tr,
                          style: TextStyle(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w900,
                            color: Colors.black45,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      SizedBox(
                        width: 80.w,
                        child: Text(
                          "login_body_text".tr,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.black54,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      CustomizedTextField(
                        controller: controller.phone,
                          hintText: "phone".tr,
                          icon: Icons.phone_outlined,
                          keyboardtype: TextInputType.phone,
                          obscure: false),
                      SizedBox(
                        height: 2.h,
                      ),
                      CustomizedTextField(
                        controller: controller.password,
                        hintText: "password".tr,
                        icon: Icons.lock,
                        keyboardtype: TextInputType.visiblePassword,
                        obscure: true,
                        suffix: TextButton(
                          onPressed: () {
                            Get.toNamed('/forgot_password');
                          },
                          child: Text(
                            "forgot_password".tr,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      CupertinoButton(
                        child: Row(
                          children: [
                            Icon(
                              Icons.circle_outlined,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            LimitedText(
                              text: "privacy".tr,
                              fontSize: 10.sp,
                            )
                          ],
                        ),
                        onPressed: () {},
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Obx(() {
                        return MainButton(
                            text: controller.isSending.value
                                ? "loading".tr
                                : "login".tr,
                            clicked: () {
                              if (controller.isSending.value) {
                                return;
                              }
                              controller.login();
                            });
                      }),
                    ],
                  ),
                ),
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
