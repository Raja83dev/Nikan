import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nikan_app/constans.dart';
import 'package:nikan_app/controllers/profile_controller.dart';
import 'package:nikan_app/widgets/main_button.dart';
import 'package:nikan_app/widgets/neu_text_field.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:sizer/sizer.dart';

class EditProfilePage extends GetView<ProfileController> {
  EditProfilePage({super.key});
  final formKey = GlobalKey<FormState>();

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
        if (controller.isloadingProfile.value) {
          return Center(child: SpinKitDualRing(color: accentColor));
        }
        return SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 6.h,
                ),
                InkWell(
                  onTap: () {
                    print("ENABLE");
                    controller.selectImage();
                  },
                  child: Builder(
                    builder: (context) {
                      print(
                          "${controller.uploadimage}=${controller.userData!.avatar}");
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
                          child: Image.file(
                            File("image.path"),
                            fit: BoxFit.cover,
                          ),
                        );
                      } else if (controller.userData!.avatar!.length > 4) {
                        print("Show Other");
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
                controller.isloadingProfile.value
                    ? SpinKitCubeGrid(
                        color: Colors.indigo,
                      )
                    : ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(accentColor)),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            return;
                            //check if form data are valid,
                            // your process task ahed if all data are valid
                          }

                          if (controller.userData!.avatar == "100") {
                            Get.defaultDialog(
                              title: "warning".tr,
                              titleStyle: PersianFonts.Vazir.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                              middleText: "not_selected_image".tr,
                              middleTextStyle: PersianFonts.Vazir.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                              confirm: CupertinoButton(
                                child: Text(
                                  "i_get_it".tr,
                                  style: PersianFonts.Vazir.copyWith(
                                    color: Colors.red[700],
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                            );

                            return;
                          }

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
          ),
        );
      }),
    );
  }
}
