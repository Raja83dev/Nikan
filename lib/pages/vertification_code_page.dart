import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:nikan_app/controllers/login_controller.dart';
import 'package:nikan_app/widgets/main_button.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';

import '../widgets/dont_have_account_button.dart';

class VertificationCodePage extends GetView<LoginController> {
  VertificationCodePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.isSending.value = false;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        return Center(
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
                SizedBox(width: 90.w, child: _inputs(context)),
                SizedBox(
                  height: 3.h,
                ),
                MainButton(
                    text: controller.isSending.value
                        ? "loading".tr
                        : "next".tr,
                    clicked: () {
                      if (controller.isSending.value) {
                        return;
                      }
                      controller.activeCode();
                    }),
                SizedBox(
                  height: 3.h,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _inputs(BuildContext context) {
    return PinCodeTextField(
      readOnly: controller.isSending.value,
      length: 6,
      obscureText: false,
      keyboardType: TextInputType.phone,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        disabledColor: Colors.grey.withOpacity(0.2),
        inactiveFillColor: Colors.grey.withOpacity(0.2),
        inactiveColor: Colors.grey.withOpacity(0.2),
        borderWidth: 0.1,
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        fieldWidth: 40,
        activeFillColor: Colors.white,
      ),
      animationDuration: Duration(milliseconds: 300),
      enableActiveFill: true,
      onCompleted: (String v) {
        controller.code.value = v;
        controller.activeCode();
      },
      onChanged: (value) {
        controller.code.value = value;
      },
      beforeTextPaste: (text) {
        print("Allowing to paste $text");

        return true;
      },
      appContext: context,
    );
  }
}
