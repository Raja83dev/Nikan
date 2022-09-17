import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:nikan_app/controllers/profile_controller.dart';
import 'package:nikan_app/widgets/main_button.dart';
import 'package:nikan_app/widgets/neu_text_field.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:sizer/sizer.dart';

class EditProfilePage extends GetView<ProfileController> {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
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
          return Center(child: SpinKitDualRing(color: Colors.indigo));
        }
        return SingleChildScrollView(
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
                child: controller.userData!.avatar == "100"
                    ? CircleAvatar(
                        radius: 15.w,
                        child: Text(
                          "select_profile_image".tr,
                          textAlign: TextAlign.center,
                          style: PersianFonts.Vazir.copyWith(
                              fontWeight: FontWeight.w600, fontSize: 10.sp),
                        ),
                      )
                    : CircleAvatar(
                        radius: 15.w,
                        backgroundImage: CachedNetworkImageProvider(
                          controller.userData!.avatar!,
                        ),
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
                controller: controller.passwordField,
                keyboardType: TextInputType.visiblePassword,
                label: "password".tr,
              ),
              NeuTextField(
                controller: controller.idNumberField,
                keyboardType: TextInputType.emailAddress,
                label: "id_number".tr,
              ),
              NeuTextField(
                controller: controller.bornField,
                keyboardType: TextInputType.emailAddress,
                label: "born".tr,
              ),
              NeuTextField(
                controller: controller.jobField,
                keyboardType: TextInputType.emailAddress,
                label: "job".tr,
              ),
              SizedBox(
                height: 3.h,
              ),
              controller.isloadingProfile.value
                  ? SpinKitCubeGrid(
                      color: Colors.indigo,
                    )
                  : MainButton(
                      text: "save".tr,
                      clicked: controller.saveUserData,
                    ),
            ],
          ),
        );
      }),
    );
  }
}
