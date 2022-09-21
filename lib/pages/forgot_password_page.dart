import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nikan_app/controllers/login_controller.dart';
import 'package:nikan_app/pages/signup_page.dart';
import 'package:nikan_app/widgets/main_button.dart';
import 'package:sizer/sizer.dart';

import '../widgets/customized_text_field.dart';
import '../widgets/dont_have_account_button.dart';

class ForgotPasswordPage extends GetView<LoginController> {
  ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.isSending.value = false;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 8.h,
              ),
              SizedBox(
                width: 80.w,
                height: 30.h,
                child: Image.asset(
                  "assets/icons/nikan_logo.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
              SizedBox(
                height: 6.h,
              ),
              SizedBox(
                width: 90.w,
                child: Text(
                  "forgot_your_password".tr,
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
              CustomizedTextField(
                  hintText: "phone".tr,
                  icon: Icons.phone_outlined,
                  keyboardtype: TextInputType.phone,
                  controller: controller.phone,
                  obscure: false),
              SizedBox(
                height: 2.h,
              ),
              Obx(() {
                return MainButton(
                    text: controller.isSending.value ? "sending".tr : "send".tr,
                    clicked: () {
                      if (controller.isSending.value == true) {
                        return;
                      }
                      //   FocusScope.of(context).nextFocus();
                      controller.forgotPass();
                    });
              }),
              SizedBox(
                height: 2.h,
              ),
              DontHaveAccountButton(
                text: "dont_have_account".tr,
                btnText: "sign_up".tr,
                clicked: () {
                  controller.isSending.value = false;
                  Get.to(() => SignUpPage());
                },
              ),
            ],
          ),
        ),
      ).paddingSymmetric(horizontal: 5.w),
    );
  }
}
