import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nikan_app/constans.dart';
import 'package:nikan_app/controllers/edit_profile_controller.dart';
import 'package:nikan_app/controllers/profile_controller.dart';
import 'package:nikan_app/widgets/main_button.dart';
import 'package:nikan_app/widgets/neu_text_field.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:sizer/sizer.dart';

class EditProfilePage extends GetView<EditProfileController> {
  EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: accentColor,
        centerTitle: true,
        title: Text(
          "edit_profile".tr,
          style: PersianFonts.Vazir.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isloading.value) {
          return SpinKitDoubleBounce(
            color: accentColor,
          );
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 3.h,
              ),
              InkWell(
                onTap: () {
                  print("ENABLE");
                  controller.selectImage();
                },
                child: Builder(
                  builder: (context) {
        print("Update");
                    if (controller.uploadimage == "100") {
                      print("Avatar is 100");
                      return CircleAvatar(
                        radius: 15.w,
                        child: Text(
                          "select_profile_image".tr,
                          textAlign: TextAlign.center,
                          style: PersianFonts.Vazir.copyWith(
                              fontWeight: FontWeight.w600, fontSize: 10.sp),
                        ),
                      );
                    } else if (controller.uploadimage !=
                        controller.userData!.avatar!) {
                      print("Show PhotoView");
                      return CircleAvatar(
                        radius: 15.w,
                        backgroundImage: FileImage(
                          File(controller.uploadimage!),
                        ),
                      );
                    } else if (controller.userData!.avatar!.length > 4) {
                      print("Show Other ${controller.userData!.avatar!}");
                      return CircleAvatar(
                        radius: 15.w,
                        backgroundImage: CachedNetworkImageProvider(
                          controller.userData!.avatar!,
                        ),
                      );
                    } else {
                      return CircleAvatar(
                        radius: 15.w,
                        child: Text(
                          controller.userData!.fullName![0],
                          textAlign: TextAlign.center,
                          style: PersianFonts.Vazir.copyWith(
                              fontWeight: FontWeight.w600, fontSize: 10.sp),
                        ),
                      );
                    }

                    // controller.userData!.avatar == "100"
                    //     ? CircleAvatar(
                    //         radius: 15.w,
                    //         child: Text(
                    //           "select_profile_image".tr,
                    //           textAlign: TextAlign.center,
                    //           style: PersianFonts.Vazir.copyWith(
                    //               fontWeight: FontWeight.w600,
                    //               fontSize: 10.sp),
                    //         ),
                    //       )
                    //     : CircleAvatar(
                    //         radius: 15.w,
                    //         backgroundImage: CachedNetworkImageProvider(
                    //           controller.userData!.avatar!,
                    //         ),
                    //       );
                  },
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              NeuTextField(
                controller: controller.nameField,
                keyboardType: TextInputType.name,
                label: "fullname".tr,
              ),
              NeuTextField(
                readOnly: true,
                controller: controller.phoneField,
                keyboardType: TextInputType.phone,
                label: "phone".tr,
              ),
              NeuTextField(
                controller: controller.emailField,
                keyboardType: TextInputType.emailAddress,
                label: "email".tr,
              ),
              NeuTextField(
                controller: controller.idNumberField,
                keyboardType: TextInputType.number,
                label: "id_number".tr,
              ),
              NeuTextField(
                controller: controller.bornField,
                keyboardType: TextInputType.datetime,
                label: "born".tr,
              ),
              NeuTextField(
                controller: controller.jobField,
                keyboardType: TextInputType.text,
                label: "job".tr,
              ),
              SizedBox(
                height: 3.h,
              ),
              controller.isloading.value
                  ? SpinKitCubeGrid(
                      color: Colors.indigo,
                    )
                  : ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(accentColor)),
                      onPressed: () {
                        controller.saveUserData();
                      },
                      child: SizedBox(
                        width: 80.w,
                        height: 6.h,
                        child: Center(
                          child: Text(
                            "save".tr,
                            style: PersianFonts.Yekan.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        );
      }),
    );
  }
}
