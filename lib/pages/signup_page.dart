import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch_clipper/flutter_switch_clipper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:nikan_app/controllers/login_controller.dart';
import 'package:nikan_app/pages/login_page.dart';

import 'package:nikan_app/widgets/customized_text_field.dart';
import 'package:nikan_app/widgets/dont_have_account_button.dart';

import 'package:nikan_app/widgets/main_button.dart';
import 'package:sizer/sizer.dart';
import 'package:lottie/lottie.dart';

class SignUpPage extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    controller.phone.text = "";
controller.isSending.value=false;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
               SizedBox(height: 8.h,),
               
              SizedBox(
                width: 80.w,
                height: 30.h,
                child: Image.asset(
                  "assets/icons/nikan_logo.png",
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 80.w,
                child: Text(
                  "sign_up".tr,
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w900,
                    color: Colors.black54,
                  ),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              SizedBox(
                width: 80.w,
                child: Text(
                  "login_body_text".tr,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.black87,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              CustomizedTextField(
                controller: controller.phone,
                hintText: "phone".tr,
                icon: Icons.phone_outlined,
                keyboardtype: TextInputType.phone,
                obscure: false,
              ),
              SizedBox(
                height: 3.h,
              ),
              Obx(() {
                return MainButton(
                    text: controller.isSending.value
                        ? "loading".tr
                        : "sign_up".tr,
                    clicked: () {
                      if (controller.isSending.value) {
                        return;
                      }
                      controller.signUp();
                    });
              }),
              SizedBox(
                height: 2.h,
              ),
              DontHaveAccountButton(
                text: "have_account".tr,
                btnText: "login".tr,
                clicked: () {
                  Get.to(()=>LoginPage());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
