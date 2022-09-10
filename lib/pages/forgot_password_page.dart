import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nikan_app/widgets/main_button.dart';
import 'package:sizer/sizer.dart';

import '../widgets/customized_text_field.dart';
import '../widgets/dont_have_account_button.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

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
                  hintText: "email".tr,
                  icon: Icons.email,
                  keyboardtype: TextInputType.emailAddress,
                  obscure: false),
              SizedBox(
                height: 2.h,
              ),
              MainButton(text: "next".tr, clicked: () {}),
              SizedBox(
                height: 2.h,
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
        ).paddingSymmetric(horizontal: 5.w),
      ),
    );
  }
}
